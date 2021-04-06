require "ibanity"

RSpec.describe Ibanity::BaseResource do
  describe "#relationship_klass" do
    context "when 'data' attribute is present" do
      let(:json) { Fixture.load_json("account.json") }

      it "retrieves the resource name from the 'type' attribute if it is present" do
        json["relationships"]["fi"] = json["relationships"]["financialInstitution"]
        json["relationships"].delete("financialInstitution")

        actual = Ibanity::Xs2a::Account.new(json)

        expect(actual).to respond_to(:financial_institution)
      end

      it "retrieves the resource name from the 'type' attribute if it is present" do
        actual = Ibanity::Xs2a::Account.new(json)

        expect(actual).to respond_to(:financial_institution)
      end
    end
  end
end
