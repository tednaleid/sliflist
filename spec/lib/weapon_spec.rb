describe Weapon do

  let(:perk_slots) {
    {
      'barrels'     => {'t' => 1, 'c' => 2},
      'magazines'   => {'t' => 3, 'c' => 4},
      'perks1'      => {'t' => 5, 'c' => 6},
      'perks2'      => {'t' => 7, 'c' => 8},
      'masterworks' => {'t' => 9, 'c' => 10}
    }
  }

  let(:data_hash) {{
    'name'     => 'TEST_WEAPON_NAME',
    'item_id'  => 123,
    'overview' => 'TEST_OVERVIEW',
    'drop_id'  => 'vog',
    'traits'   => perk_slots,
  }}

  subject { Weapon.from_hash(data_hash) }

  describe '.from_hash' do
    it 'returns a weapon' do
      expect(subject).to be_a(Weapon)
    end
  end

  describe '#name' do
    it 'returns the name of the weapon' do
      expect(subject.name).to eq('TEST_WEAPON_NAME')
    end
  end

  describe '#item_id' do
    it 'returns the Bungie Item ID of the weapon' do
      expect(subject.item_id).to eq(123)
    end
  end

  describe '#overview' do
    it 'returns the overview' do
      expect(subject.overview).to eq('TEST_OVERVIEW')
    end
  end

  describe '#drop_source' do
    it 'returns where the weapon drops from' do
      expect(subject.drop_source).to eq(DropSource.from_id('vog'))
    end
  end

  describe '#perk_slots' do
    it 'returns the configured perk slots' do
      expect(subject.perk_slots).to match_array(PerkSlot.perk_slots_from_hash(perk_slots))
    end
  end

end