require 'ibanity'

RSpec.describe Ibanity::Webhook::Signature do
  subject(:signature_module) { described_class }

  let(:client) { instance_double("Ibanity::Client") }

  before do
    allow(Ibanity).to receive(:client).and_return(client)
    allow(Ibanity).to receive(:webhook_keys).and_return(
      [
        Ibanity::Webhooks::Key.new(
          alg: "RS512",
          e: "AQAB",
          kid: "sandbox_events_signature_1",
          kty: "RSA",
          n: "v9qVZmotpil47Pw2NOmP11bpE5B_GtG6ICfqtm13Uusa4asf4FWedclr-kQTV2Ly5rSItq2f3RGRNyove_4TiTIbx21rwM5HP0iFhlVaqHjkr1iSmKzCFojOnTM4UwKQNROhDVDC6TWIzSafZkBacUrCX5l0PLSh2aEK8aiopu5ajYpOr8Ipjw_mbKXxBfcxtjgskbXPyEcf6xlB_Dygl9-btAvRTKiuie4qAWANTdVAgSnddjZMJxFnndZMCH1h-z4ISwphBYbwG2aZrZ7RfHnoIROxsdmKeostYtHy3gMR4_poufzFRR8lpvODd3m7lzdXKBTCvzlQYBNpmf6gmG9p08laE-h67F1GoqvuqspcvRlVpGZEzEwRIbPMAaS4_omCSj4HFZyo58PLUsAp--AD8GGFfVMyBdFhTEkr2235O5AP4UMdHuvyP-NPFCsqibqKK1GIl_Hy0UXnqg7-MCGqs4jX1k4IZZ3wDwza30f1O6tUtaOT8YXzZ2ZWnVWyMLcNx6gep8t3A7gTzEXcselrJgO6SLFRhYA0QmtIRtTwnl-8OmjEi5AJVzO0e-yiRj7g_JLEmgG3pDwmvbiXzEqkY5mPqJMB9G5qcd0SWgvvZs02_1tRRhvw0D5BTKfcEcLW9PKm8Nts1_BGSXKOhTSeQgxuw4iC63ST3dtpl-0=",
          status: "ACTIVE",
          use: "sig"
        )
      ]
    )
    allow(client).to receive(:application_id).and_return("e643b5be-ccb1-4a38-b7b6-36689853bef5")
    allow(client).to receive(:base_uri).and_return("https://api.ibanity.com")
  end

  describe ".verify!" do
    let(:payload) { Fixture.load_unparsed_json("webhooks/example_payload.json") }
    let(:signature) { Fixture.load_signature("webhooks/example_signature.sig") }
    let(:tolerance) { Time.now.to_i + 10 - 1691670985 }

    it "returns true for a correct signature" do
      expect(signature_module.verify!(payload, signature, tolerance)).to be_truthy
    end

    it "raises an error if the contents are altered" do
      expect do
        signature_module.verify!(payload + "altered", signature, tolerance)
      end.to raise_error(Ibanity::Error, /The signature digest is invalid/)
    end

    it "raises an error if the signature is expired" do
      expect do
        signature_module.verify!(payload, signature, 0)
      end.to raise_error(Ibanity::Error, /The signature exp is invalid/)
    end

    it "raises an error if the audience is invalid" do
      allow(client).to receive(:application_id).and_return("invalid")
      expect do
        signature_module.verify!(payload, signature, tolerance)
      end.to raise_error(Ibanity::Error, /The signature aud is invalid/)
    end

    it "raises an error if the issuer is invalid" do
      allow(client).to receive(:base_uri).and_return("invalid")
      expect do
        signature_module.verify!(payload, signature, tolerance)
      end.to raise_error(Ibanity::Error, /The signature iss is invalid/)
    end

    it "raises an error if the signing key is unavailable" do
      allow(Ibanity).to receive(:webhook_keys).and_return([])
      expect do
        signature_module.verify!(payload, signature, tolerance)
      end.to raise_error(Ibanity::Error, /The key id from the header didn't match an available signing key/)
    end

    it "raises an error if the signature is altered" do
      expect do
        signature_module.verify!(payload, signature + "altered", tolerance)
      end.to raise_error(Ibanity::Error, /The signature verification failed/)
    end
  end
end