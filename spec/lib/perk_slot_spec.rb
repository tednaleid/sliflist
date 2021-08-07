describe PerkSlot do

  subject { PerkSlot.new('barrels', 9, 2) }

  describe '#name' do
    it 'returns the name of the perk slot' do
      expect(subject.name).to eq('barrels')
    end
  end

  describe '#slot_count' do
    it 'returns the number of slots available for perks' do
      expect(subject.slot_count).to eq(2)
    end
  end

  describe '#possible_perk_count' do
    it 'returns the number of perks possible in that "column", usually 5-9' do
      expect(subject.possible_perk_count).to eq(9)
    end
  end

  describe '.perk_slots_from_hash' do
    let(:data_hash) {
      {
        'barrels'     => {'t' => 1, 'c' => 2},
        'magazines'   => {'t' => 3, 'c' => 4},
        'perks1'      => {'t' => 5, 'c' => 6},
        'perks2'      => {'t' => 7, 'c' => 8},
        'masterworks' => {'t' => 9, 'c' => 10}
      }
    }
    let(:specified_slots) { PerkSlot.perk_slots_from_hash(data_hash) }

    context 'when all of the perk slots have valid names' do

      it 'returns the number of perk slots configured' do
        expect(specified_slots.length).to eq(5)
      end

      it 'returns the perk slots as configured' do
        expect(specified_slots).to have_key('barrels')
        expect(specified_slots['barrels'].possible_perk_count).to eq(1)
        expect(specified_slots['barrels'].slot_count).to eq(2)

        expect(specified_slots).to have_key('magazines')
        expect(specified_slots['magazines'].possible_perk_count).to eq(3)
        expect(specified_slots['magazines'].slot_count).to eq(4)

        expect(specified_slots).to have_key('perks1')
        expect(specified_slots['perks1'].possible_perk_count).to eq(5)
        expect(specified_slots['perks1'].slot_count).to eq(6)

        expect(specified_slots).to have_key('perks2')
        expect(specified_slots['perks2'].possible_perk_count).to eq(7)
        expect(specified_slots['perks2'].slot_count).to eq(8)

        expect(specified_slots).to have_key('masterworks')
        expect(specified_slots['masterworks'].possible_perk_count).to eq(9)
        expect(specified_slots['masterworks'].slot_count).to eq(10)
      end

    end

    context 'when any of the perks are not valid slot names' do
      let(:data_hash) {
        {
          'BAD_PERK_NAME' => {'t' => 1, 'c' => 2}
        }
      }
      it 'raises an error' do
        expect { PerkSlot.perk_slots_from_hash(data_hash) }.to raise_error("'BAD_PERK_NAME' is not a valid perk slot name")
      end
    end 
  end

end