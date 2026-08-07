require "ibanity"

RSpec.describe Ibanity::IsabelConnect::PaymentStatus do
  let(:client) { instance_double("Ibanity::Client") }
  let(:access_token) { "test-access-token" }
  let(:base_uri) { "https://api.ibanity.com/isabel-connect/bulk-payment-initiation-requests/{bulkPaymentInitiationRequestId}" }
  let(:payment_id) { "90000036388323" }
  let(:payment_status_uri) { "https://api.ibanity.com/isabel-connect/bulk-payment-initiation-requests/#{payment_id}/payment-status" }
  let(:xml_response) { "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Document><CstmrPmtStsRpt></CstmrPmtStsRpt></Document>" }

  before do
    allow(Ibanity).to receive(:client).and_return(client)
    allow(Ibanity).to receive(:isabel_connect_api_schema).and_return(
      { "bulkPaymentInitiationRequests" => base_uri }
    )
  end

  describe ".find" do
    context "without a notification_id" do
      before do
        allow(client).to receive(:get)
          .with(uri: payment_status_uri, query_params: {}, customer_access_token: access_token)
          .and_return(xml_response)
      end

      it "returns the raw XML response" do
        result = described_class.find(id: payment_id, access_token: access_token)
        expect(result).to eq(xml_response)
      end

      it "calls GET on the correct URI" do
        expect(client).to receive(:get)
          .with(uri: payment_status_uri, query_params: {}, customer_access_token: access_token)
          .and_return(xml_response)

        described_class.find(id: payment_id, access_token: access_token)
      end
    end

    context "with a notification_id" do
      let(:notification_id) { "a" }

      before do
        allow(client).to receive(:get)
          .with(uri: payment_status_uri, query_params: { notificationId: notification_id }, customer_access_token: access_token)
          .and_return(xml_response)
      end

      it "passes notificationId as a query parameter" do
        expect(client).to receive(:get)
          .with(uri: payment_status_uri, query_params: { notificationId: notification_id }, customer_access_token: access_token)
          .and_return(xml_response)

        described_class.find(id: payment_id, access_token: access_token, notification_id: notification_id)
      end
    end
  end
end
