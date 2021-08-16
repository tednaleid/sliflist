describe Variant do

  before do
    FileUtils.mkdir_p('rolls/world_drops')
    FileUtils.cp('./fixtures/rolls/hung_jury_adept.yml', 'rolls/world_drops')

    FileUtils.mkdir_p('data/weapons')
    FileUtils.cp('./fixtures/weapons/hung_jury_adept.yml', 'data/weapons')
  end

  subject {
    Variant.new(
      Ada1.weapon_from_id(681067419),
      'TEST_NAME',
      {
        'barrels' => [Perk.from_name('Polygonal Rifling')],
        'magazines' => [Perk.from_name('Steady Rounds')],
        'perks1' => [Perk.from_name('Moving Target'), Perk.from_name('Rapid Hit'), Perk.from_name('Heating Up')],
        'perks2' => [Perk.from_name('Box Breathing')],
        'masterworks' => [Perk.from_name('Stability MW')]
      }
    )
  }

  describe '#weapon' do
    it 'returns the name' do
      expect(subject.weapon).to be_a(Weapon)
      expect(subject.weapon.item_id).to eq(681067419)
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
      expect(subject.perks).to include('barrels' => [Perk.from_name('Polygonal Rifling')])
      expect(subject.perks).to include('magazines' => [Perk.from_name('Steady Rounds')])
      expect(subject.perks).to include('perks1' => [Perk.from_name('Moving Target'), Perk.from_name('Rapid Hit'), Perk.from_name('Heating Up')])
      expect(subject.perks).to include('perks2' => [Perk.from_name('Box Breathing')])
      expect(subject.perks).to include('masterworks' => [Perk.from_name('Stability MW')])
    end
  end

  describe '#probability' do
    it 'returns the chance that the variant occurs in one drop' do
      expect(subject.probability.round(2)).to eq(0.19)
    end
  end

  describe '#average_rolls_required' do
    it 'returns the average number of drops required to get this variant' do
      expect(subject.average_rolls_required).to eq(525)
    end
  end
end