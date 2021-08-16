describe Variant do

  before do
    FileUtils.mkdir_p('rolls/s14')
    FileUtils.cp('./fixtures/rolls/chroma_rush.yml', 'rolls/s14')

    FileUtils.mkdir_p('data/weapons')
    FileUtils.cp('./fixtures/weapons/chroma_rush.yml', 'data/weapons')
  end

  subject {
    Variant.new(
      Ada1.weapon_from_id(1119734784),
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

  describe '#weapon' do
    it 'returns the name' do
      expect(subject.weapon).to be_a(Weapon)
      expect(subject.weapon.item_id).to eq(1119734784)
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