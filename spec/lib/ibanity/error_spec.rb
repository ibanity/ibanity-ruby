class MyClass
  def call_without_errors
    raise Ibanity::Error, []
  end

  def call_with_errors
    errors = [
        {:attribute => 'attr1', :code => 400, :message => 'not found'},
        {:code => 401, :message => 'unauthorized'}
    ]
    raise Ibanity::Error, errors
  end
end

describe Ibanity::Error do
  let(:obj) {MyClass.new}
  context 'given Ibanity exception without errors' do
    it 'returns a string representation of Ibanity::Error class' do
      expect {obj.call_without_errors}.to raise_error {|error|
        expect(error.is_a?(StandardError)).to eq(true)
        expect(error.to_s).to eq('Ibanity::Error')
      }
    end
  end
  context 'given Ibanity exception with errors' do
    it 'returns a string representation of the errors' do
      expect {obj.call_with_errors}.to raise_error {|error|
        expect(error.is_a?(StandardError)).to eq(true)
        expect(error.to_s.include?('*')).to eq(true)
      }
    end
  end
end
