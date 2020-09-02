require "ibanity/http_signature"

RSpec.describe Ibanity::HttpSignature do

  describe ".signature_headers" do
    let(:signature) do
      Ibanity::HttpSignature.new(
        certificate: CryptoHelper.load_certificate("test"),
        certificate_id: "ec0c29ef-3b39-4b6f-93ff-866bed032399",
        key: CryptoHelper.load_private_key("test"),
        method: "post",
        uri: "https://api.ibanity.com/xs2a/customer-access-tokens",
        headers: {"ibanity-idempotency-key" => "cf17b515-5f6f-4213-a8fe-e4cd40653d00"},
        payload: "{\"foo\": \"bar\"}",
        query_params: {}
      )
    end

    let(:parts_regex) do
      /keyId="(?<keyId>.*)",?\s?algorithm="(?<algorithm>.*)",?\s?headers="(?<headers>.*)",?\s?signature="(?<signature>.*)"/
    end

    let(:signature_parts) do
      signature.signature_headers["Signature"].match(parts_regex).named_captures
    end

    ["(created)", "Digest", "Signature"].each do |header|
      it "contains the '#{header}' header" do
        expect(signature.signature_headers).to include(header)
      end
    end

    ["keyId", "algorithm", "headers", "signature"].each do |part|
      it "has a signature containing the part '#{part}'" do
        expect(signature_parts).to include(part)
      end
    end
  end
end
