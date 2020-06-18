require 'ibanity/util'

RSpec.describe Ibanity::Util do
  describe ".underscorize" do
    it "transforms all keys to snake_case" do
      hash = {
        "currency" => "EUR",
        "amount" => 1,
        "debtorName" => "Sophie Schowalter",
        "debtorAccountReference" => "BE59823362319793",
      }

      expected = {
        "currency" => "EUR",
        "amount" => 1,
        "debtor_name" => "Sophie Schowalter",
        "debtor_account_reference" => "BE59823362319793",
      }

      expect(Ibanity::Util.underscorize(hash)).to eq(expected)
    end

    it "processes hashes recursively" do
      hash = {
        "currency" => "EUR",
        "amount" => 1,
        "debtorName" => "Sophie Schowalter",
        "details" => {
          "debtorAccountReference" => "BE59823362319793"
        }
      }

      expected = {
        "currency" => "EUR",
        "amount" => 1,
        "debtor_name" => "Sophie Schowalter",
        "details" => {
          "debtor_account_reference" => "BE59823362319793"
        }
      }

      expect(Ibanity::Util.underscorize(hash)).to eq(expected)
    end

    it "processes each array element" do
      hash = {
        "currency" => "EUR",
        "amount" => 1,
        "debtorName" => "Sophie Schowalter",
        "details" => [
          {"debtorAccountReference" => "BE59823362319793"}
        ]
      }

      expected = {
        "currency" => "EUR",
        "amount" => 1,
        "debtor_name" => "Sophie Schowalter",
        "details" => [
          {"debtor_account_reference" => "BE59823362319793"}
        ]
      }

      expect(Ibanity::Util.underscorize(hash)).to eq(expected)
    end

    it "leaves arrays elements untouched if they are not themselves hashes or arrays" do
      hash = {
        "currency" => "EUR",
        "amount" => 1,
        "debtorName" => "Sophie Schowalter",
        "details" => [
          "BE59823362319793"
        ]
      }

      expected = {
        "currency" => "EUR",
        "amount" => 1,
        "debtor_name" => "Sophie Schowalter",
        "details" => [
          "BE59823362319793"
        ]
      }

      expect(Ibanity::Util.underscorize(hash)).to eq(expected)
    end
  end
end