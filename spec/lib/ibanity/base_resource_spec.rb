require "ibanity"

class Ibanity::Xs2a::Car < Ibanity::BaseResource; end
class Ibanity::Xs2a::Manufacturer < Ibanity::BaseResource; end
class Ibanity::Xs2a::Owner < Ibanity::BaseResource; end

RSpec.describe Ibanity::BaseResource do
  describe "#relationship_klass" do
    context "when 'data' attribute is present" do
      let(:json) { Fixture.load_json("car.json") }

      it "retrieves the resource name from the 'type' attribute if it is present" do
        actual = Ibanity::Xs2a::Car.new(json)

        expect(actual).to respond_to(:manufacturer)
      end

      it "falls back to the element name otherwise" do
        actual = Ibanity::Xs2a::Car.new(json)

        expect(actual).to respond_to(:owner)
      end
    end
  end
end
