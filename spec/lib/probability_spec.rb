describe Probability do

  describe '.factorial' do
    
    context 'when zero' do
      it 'returns 1' do
        expect(Probability.factorial(0)).to eq(1)
      end
    end

    context 'when not zero' do
      it 'returns the factorial' do
        expect(Probability.factorial(1)).to eq(1)
        expect(Probability.factorial(3)).to eq(6)
        expect(Probability.factorial(5)).to eq(120)
      end
    end

  end

  describe '.combinations' do

    it 'returns the combinations from the sample size and selection' do
      expect(Probability.combinations(9,2)).to eq(36)
      expect(Probability.combinations(8,2)).to eq(28)
      expect(Probability.combinations(7,2)).to eq(21)
      expect(Probability.combinations(6,1)).to eq(6)
    end

  end

end