require "ibanity"

RSpec.describe Ibanity::IsabelConnect::PaymentNotification do
  let(:client) { instance_double("Ibanity::Client") }
  let(:access_token) { "test-access-token" }
  let(:base_uri) { "https://api.ibanity.com/isabel-connect/bulk-payment-initiation-requests/{bulkPaymentInitiationRequestId}" }
  let(:notifications_uri) { "https://api.ibanity.com/isabel-connect/bulk-payment-initiation-requests/notifications" }
  let(:notification_id) { "14e2bff5-e365-4bc7-bf48-76b7bcd464e9" }

  before do
    allow(Ibanity).to receive(:client).and_return(client)
    allow(Ibanity).to receive(:isabel_connect_api_schema).and_return(
      { "bulkPaymentInitiationRequests" => base_uri }
    )
  end

  describe ".list" do
    let(:raw_response) { Fixture.load_json("isabel_connect/payment_notifications.json") }

    before do
      allow(client).to receive(:get)
        .with(uri: notifications_uri, query_params: {}, customer_access_token: access_token, headers: nil)
        .and_return(raw_response)
    end

    it "returns a collection of payment notifications" do
      result = described_class.list(access_token: access_token)
      expect(result.length).to eq(1)
    end

    it "maps attributes correctly" do
      notification = described_class.list(access_token: access_token).first
      expect(notification.id).to eq(notification_id)
      expect(notification.notification_type).to eq("payment.status.updated")
      expect(notification.created_at).to eq("2026-06-04T14:30:00.000Z")
    end

    it "calls the correct URI" do
      expect(client).to receive(:get)
        .with(uri: notifications_uri, query_params: {}, customer_access_token: access_token, headers: nil)
        .and_return(raw_response)

      described_class.list(access_token: access_token)
    end
  end

  describe ".destroy" do
    before do
      allow(client).to receive(:delete)
        .with(uri: "#{notifications_uri}/#{notification_id}", customer_access_token: access_token)
        .and_return("")
    end

    it "returns true" do
      result = described_class.destroy(id: notification_id, access_token: access_token)
      expect(result).to be true
    end

    it "calls DELETE on the correct URI" do
      expect(client).to receive(:delete)
        .with(uri: "#{notifications_uri}/#{notification_id}", customer_access_token: access_token)
        .and_return("")

      described_class.destroy(id: notification_id, access_token: access_token)
    end
  end
end
