require "ibanity"

class Ibanity::Xs2a::Car < Ibanity::BaseResource; end
class Ibanity::Xs2a::Manufacturer < Ibanity::BaseResource; end

RSpec.describe Ibanity::BaseResource do
  describe "#relationship_klass" do
    context "when 'data' attribute is present" do
      it "retrieves the resource name from the 'type' attribute if it is present" do
        car = Ibanity::Xs2a::Car.new(Fixture.load_json("relationships/data_with_type.json"))

        expect(car).to respond_to(:manufacturer)
      end

      it "falls back to the element name otherwise" do
        car = Ibanity::Xs2a::Car.new(Fixture.load_json("relationships/data_without_type.json"))

        expect(car).to respond_to(:manufacturer)
      end
    end

      end
    end
  end
end
