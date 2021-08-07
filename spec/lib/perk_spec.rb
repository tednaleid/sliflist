describe Perk do

  subject { Perk.new('TEST_NAME', [123456789]) }

  describe '#perk_id' do
    it 'returns the Destiny ID of the perk' do
      expect(subject.perk_ids).to eq([123456789])
    end
  end

  describe '#name' do
    it 'returns the name of the perk' do
      expect(subject.name).to eq('TEST_NAME')
    end
  end

  describe '.from_name' do

    context 'when the perk name exists' do

      context 'when the perk has a single perk ID' do
        it 'retrieves the perk' do
          p = Perk.from_name('Arrowhead Brake')
          expect(p.perk_ids).to eq([839105230])
        end
      end

      context 'when the perk has multiple IDs' do
        it 'retrieves the perk' do
          p = Perk.from_name('Blast Radius MW')
          expect(p.perk_ids).to eq([3928770367, 3928770364, 3928770365, 3928770362, 3928770363, 3928770360, 3928770361, 3928770358, 3928770359, 3803457565])
        end
      end
    end

    context 'when the perk name does not exist' do
      it 'raises an error' do
        expect { Perk.from_name('Unknown Perk') }.to raise_error("Perk 'Unknown Perk'' not found in perk_ids.yml")
      end
    end

  end

end