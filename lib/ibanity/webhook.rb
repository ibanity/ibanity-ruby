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
        begin
          key_details = JOSE::JWT.peek_protected(signature_header).to_hash
          raise unless key_details["alg"] == SIGNING_ALGORITHM && key_details["kid"]
        rescue
          raise Ibanity::Error.new("Key details could not be parsed from the header", nil)
        end

        key = Ibanity.webhook_keys.find { |key| key.kid == key_details["kid"] }

        if key.nil?
          raise Ibanity::Error.new("The key id from the header didn't match an available signing key", nil)
        end
        signer = JOSE::JWK.from(key.to_h {|key, value| [key.to_s, value] })
        verified, claims_string, _jws = JOSE::JWT.verify_strict(signer, [SIGNING_ALGORITHM], signature_header)

        raise Ibanity::Error.new("The signature verification failed", nil) unless verified

        jwt = JOSE::JWT.from(claims_string)

        validate_digest!(jwt, payload)
        validate_issued_at!(jwt, tolerance)
        validate_expiration!(jwt, tolerance)
        validate_issuer!(jwt)
        validate_audience!(jwt)

        true
      end

      private

      def self.validate_digest!(jwt, payload)
        unless Digest::SHA512.base64digest(payload) == jwt.fields["digest"]
          raise_invalid_signature_error!("digest")
        end
      end

      def self.validate_issued_at!(jwt, tolerance)
        unless jwt.fields["iat"] <= Time.now.to_i + tolerance
          raise_invalid_signature_error!("iat")
        end
      end

      def self.validate_expiration!(jwt, tolerance)
        unless jwt.fields["exp"] >= Time.now.to_i - tolerance
          raise_invalid_signature_error!("exp")
        end
      end

      def self.validate_issuer!(jwt)
        unless jwt.fields["iss"] == Ibanity.client.base_uri
          raise_invalid_signature_error!("iss")
        end
      end

      def self.validate_audience!(jwt)
        unless jwt.fields["aud"] == Ibanity.client.application_id
          raise_invalid_signature_error!("aud")
        end
      end

      def self.raise_invalid_signature_error!(field)
        raise Ibanity::Error.new("The signature #{field} is invalid", nil)
      end
    end
  end
end
