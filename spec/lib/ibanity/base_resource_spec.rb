require "ibanity"

class Ibanity::Xs2a::Car < Ibanity::BaseResource; end
class Ibanity::Xs2a::Manufacturer < Ibanity::BaseResource; end

RSpec.describe Ibanity::BaseResource do
  describe "#relationship_klass" do
    context "when 'data' attribute is present" do
      it "retrieves the resource name from the 'type' attribute if it is present" do
        car = Ibanity::Xs2a::Car.new(Fixture.load_json("relationships/data_with_type.json"))

        expect(car).to respond_to(:maker)
      end

      it "falls back to the element name otherwise" do
        car = Ibanity::Xs2a::Car.new(Fixture.load_json("relationships/data_without_type.json"))

        expect(car).to respond_to(:manufacturer)
      end
    end

    context "when the 'links' attribute is present" do
      it "retrieves the resource name from the 'type' attribute within the 'links' attribute" do
        car = Ibanity::Xs2a::Car.new(Fixture.load_json("relationships/meta_with_type.json"))
  
        expect(car).to respond_to(:manufacturer)
      end
    end

    context "when there's no 'links/related' element" do
      let(:car) { Ibanity::Xs2a::Car.new(Fixture.load_json("relationships/no_links_related.json")) }

      it "sets up a '<relationship_key>_id' property when there is a 'data/id' element" do
        expect(car.manufacturer_id).to eq("6680437c")
      end

      it "discards the relationship" do
        expect(car).not_to respond_to(:manufacturer)
      end
    end
  end
end
