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
    'pvp_comments' => 'TEST_PVP_COMMENT',
    'pve_comments' => 'TEST_PVE_COMMENT'
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

  describe '#has_pvp_comments?' do

    context 'when comments exist' do

      context 'when not empty' do
        it 'returns true' do
          expect(subject.has_pvp_comments?).to be true
        end
      end

      context 'when empty' do
        let(:w) {
          data_hash.merge!({'pvp_comments' => ''})
          Weapon.from_hash(data_hash)
        }
        it 'returns false' do
          expect(w.has_pvp_comments?).to be false
        end
      end

    end

    context 'when comments do not exist' do
      let(:w) {
        data_hash.delete('pvp_comments')
        Weapon.from_hash(data_hash)
      }
      it 'returns false' do
        expect(w.has_pvp_comments?).to be false
      end
    end
  end

  describe '#has_pve_comments?' do

    context 'when comments exist' do

      context 'when not empty' do
        it 'returns true' do
          expect(subject.has_pve_comments?).to be true
        end
      end

      context 'when empty' do
        let(:w) {
          data_hash.merge!({'pve_comments' => ''})
          Weapon.from_hash(data_hash)
        }
        it 'returns false' do
          expect(w.has_pve_comments?).to be false
        end
      end

    end

    context 'when comments do not exist' do
      let(:w) {
        data_hash.delete('pve_comments')
        Weapon.from_hash(data_hash)
      }
      it 'returns false' do
        expect(w.has_pve_comments?).to be false
      end
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