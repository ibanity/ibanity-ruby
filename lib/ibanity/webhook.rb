module Ibanity
  module Webhook
    DEFAULT_TOLERANCE = 30
    SIGNING_ALGORITHM = "RS512"

    # Initializes an Ibanity Webhooks event object from a JSON payload.
    #
    # This may raise JSON::ParserError if the payload is not valid JSON, or
    # Ibanity::Error if the signature verification fails.
    def self.construct_event!(payload, signature_header, tolerance: DEFAULT_TOLERANCE)
      Signature.verify!(payload, signature_header, tolerance)

      raw_item = JSON.parse(payload)
      klass = raw_item["data"]["type"].split(".").map{|klass| klass.sub(/\S/, &:upcase)}.join("::")
      Ibanity::Webhooks.const_get(klass).new(raw_item["data"])
    end

    module Signature
      # Verifies the signature header for a given payload.
      #
      # Raises an Ibanity::Error in the following cases:
      # - the header does not match the expected format
      # - the digest does not match the payload
      # - the issued at or expiration timestamp is not within the tolerance
      # - the audience or issuer does not match the application config
      #
      # Returns true otherwise
      def self.verify!(payload, signature_header, tolerance)
        jwks_loader = ->(options) do
          raise Ibanity::Error.new("The key id from the header didn't match an available signing key", nil) if options[:kid_not_found]

          keys = Ibanity.webhook_keys.select { |key| key.use == "sig" }
                                     .map { |key| JWT::JWK.new(key.to_h {|key, value| [key.to_s, value] }) }
          JWT::JWK::Set.new(keys)
        end

        options = {
          aud: Ibanity.client.application_id,
          algorithm: SIGNING_ALGORITHM,
          exp_leeway: tolerance,
          iss: Ibanity.client.base_uri,
          jwks: jwks_loader,
          verify_aud: true,
          verify_iss: true
        }
        jwts = JWT.decode(signature_header, nil, true, options)
        jwt = jwts.first

        validate_digest!(jwt, payload)
        validate_issued_at!(jwt, tolerance)

        true
      rescue JWT::ExpiredSignature
        raise_invalid_signature_error!("exp")
      rescue JWT::IncorrectAlgorithm
        raise Ibanity::Error.new("Incorrect algorithm for signature", nil)
      rescue JWT::InvalidAudError
        raise_invalid_signature_error!("aud")
      rescue JWT::InvalidIssuerError
        raise_invalid_signature_error!("iss")
      rescue JWT::DecodeError
        raise Ibanity::Error.new("The signature verification failed", nil)
      end

      private

      def self.validate_digest!(jwt, payload)
        unless Digest::SHA512.base64digest(payload) == jwt["digest"]
          raise_invalid_signature_error!("digest")
        end
      end

      def self.validate_issued_at!(jwt, tolerance)
        unless jwt["iat"] <= Time.now.to_i + tolerance
          raise_invalid_signature_error!("iat")
        end
      end

      def self.raise_invalid_signature_error!(field)
        raise Ibanity::Error.new("The signature #{field} is invalid", nil)
      end
    end
  end
end
