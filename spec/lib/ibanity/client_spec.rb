require "ibanity"

RSpec.describe Ibanity::Client do
  let(:client) do
    described_class.new(
      certificate: CryptoHelper.load_certificate("test").to_pem,
      key: CryptoHelper.load_private_key("test").to_pem,
      key_passphrase: nil
    )
  end

  def fake_response(body, headers: {})
    response = String.new(body)
    response.define_singleton_method(:headers) { headers }
    response.define_singleton_method(:body) { self }
    response
  end

  before do
    allow(RestClient::Request).to receive(:execute).and_return(raw_response)
  end

  describe "#get" do
    context "without expose_headers" do
      let(:raw_response) { fake_response('{"foo":"bar"}') }

      it "returns the parsed body, unchanged from before" do
        expect(client.get(uri: "https://example.com")).to eq("foo" => "bar")
      end
    end

    context "with expose_headers" do
      let(:raw_response) do
        fake_response("", headers: { x_notification_status: "upToDate", ibanity_request_id: "req-1" })
      end

      it "returns the body alongside only the requested headers" do
        result = client.get(uri: "https://example.com", expose_headers: [:x_notification_status])

        expect(result).to eq(body: "", headers: { x_notification_status: "upToDate" })
      end
    end
  end
end
