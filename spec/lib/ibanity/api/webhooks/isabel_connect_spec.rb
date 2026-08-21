RSpec.describe Ibanity::Webhooks::IsabelConnect do
  before do
    allow(Ibanity::Webhook::Signature).to receive(:verify!).and_return(true)
  end

  describe "Payment::Status::Updated" do
    subject(:event) do
      Ibanity::Webhook.construct_event!(
        Fixture.load_unparsed_json("webhooks/isabel_connect/payment_status_updated.json"),
        "signature"
      )
    end

    it "resolves to the correct class" do
      expect(event).to be_a(Ibanity::Webhooks::IsabelConnect::Payment::Status::Updated)
    end

    it "exposes the id" do
      expect(event.id).to eq("550e8400-e29b-41d4-a716-446655440000")
    end

    it "exposes the notification_type" do
      expect(event.notification_type).to eq("payment.status.updated")
    end

    it "exposes the created_at" do
      expect(event.created_at).to eq("2026-06-04T14:30:00.000Z")
    end

    it "exposes the payment_id" do
      expect(event.payment_id).to eq("90000036388319")
    end
  end
end
