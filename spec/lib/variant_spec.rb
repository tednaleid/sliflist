describe Variant do

  subject {
    Variant.new(
      'TEST_WEAPON_ID',
      'TEST_NAME',
      {
        'barrels' => [Perk.from_name('Arrowhead Brake')],
        'magazines' => [Perk.from_name('Accurized Rounds')],
        'perks1' => [Perk.from_name('Backup Plan')],
        'perks2' => [Perk.from_name('Rampage')],
        'masterworks' => [Perk.from_name('Range MW')]
      }
    )
  }

  describe '#weapon_id' do
    it 'returns the name' do
      expect(subject.weapon_id).to eq('TEST_WEAPON_ID')
    end
  end

  describe '#name' do
    it 'returns the name' do
      expect(subject.name).to eq('TEST_NAME')
    end
  end

  describe '#perks' do
    it 'returns the perks' do
      expect(subject.perks.length).to eq(5)
      expect(subject.perks).to include('barrels' => [Perk.from_name('Arrowhead Brake')])
      expect(subject.perks).to include('magazines' => [Perk.from_name('Accurized Rounds')])
      expect(subject.perks).to include('perks1' => [Perk.from_name('Backup Plan')])
      expect(subject.perks).to include('perks2' => [Perk.from_name('Rampage')])
      expect(subject.perks).to include('masterworks' => [Perk.from_name('Range MW')])
    end
  end
end