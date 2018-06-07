describe Ibanity::Util do
  describe '.camelize' do
    context 'given a string and uppercase_first_letter set to true' do
      it 'returns a camel-cased string with first letter capitalized' do
        expect(Ibanity::Util.camelize('brown_fox')).to eq('BrownFox')
      end
    end

    context 'given a string and uppercase_first_letter set to false' do
      it 'returns a camel-cased string with first letter lower-cased' do
        expect(Ibanity::Util.camelize('brown_fox', false)).to eq('brownFox')
      end
    end
  end

  describe '.underscore' do
    context 'given a camel-cased string' do
      it 'returns an underscore separated string' do
        expect(Ibanity::Util.underscore('brownFox')).to eq('brown_fox')
      end
    end
  end

  describe '.underscorize_hash' do
    context 'given a hash with camel-cased keys' do
      it 'returns a hash with keys underscorized' do
        hash = {BrownFox: 'Belgian', LazyDog: 'German'}
        expect(Ibanity::Util.underscorize_hash(hash)).to eq('brown_fox' => 'Belgian', 'lazy_dog' => 'German')
      end
    end
  end
end
