describe DropSource do

  subject { DropSource.new('TEST_NAME', 123) }

  describe '#source_id' do
    it 'returns the source ID of the drop source' do
      expect(subject.source_id).to eq(123)
    end
  end

  describe '#name' do
    it 'returns the name of the drop source' do
      expect(subject.name).to eq('TEST_NAME')
    end
  end

  describe '.from_id' do
    context 'when the drop source exists' do
      it 'retrieves the drop source' do
        expect(DropSource.from_id(14).name).to eq('S14 - Season of the Splicer')
        expect(DropSource.from_id('vog').name).to eq('Raid - Vault of Glass')
      end
    end

    context 'when the drop source does not exist' do
      it 'raises an error' do
        expect { DropSource.from_id(1977) }.to raise_error("Drop Source w/ID '1977' not found in drop_sources.yml")
      end
    end
  end

  # TODO - This is brittle based on the order of the actual drop sources
  describe '.source_ordering' do
    it 'reports the sources in the order they appear in the file' do
      source = DropSource.source_ordering
      expect(source[0].source_id).to eq(14)
      expect(source[1].source_id).to eq('world')
      expect(source[2].source_id).to eq('nf')
    end
  end
end