describe AsherMir do

  let(:roll) {
    Roll.new(
      1119734784,
      'Chasing Stability',
      '🏃‍♂️',
      ['pve','pvp'],
      'Big time Stability roll',
      {
        'barrels'     => [Perk.from_name('Arrowhead Brake')],
        'magazines'   => [Perk.from_name('Steady Rounds')],
        'perks1'      => [Perk.from_name('Tunnel Vision')],
        'perks2'      => [Perk.from_name('Kill Clip')],
        'masterworks' => [Perk.from_name('Range MW')]
      },
      {
        'barrels'     => [Perk.from_name('Arrowhead Brake'), Perk.from_name('Polygonal Rifling')],
        'magazines'   => [Perk.from_name('Steady Rounds'), Perk.from_name('Accurized Rounds')],
      }
    )
  }

  # One perk per slot
  let(:ce_variant) { Banshee44.roll_store[0].variants[0] }
  let(:ce_gold) { 
    FakeFS.deactivate!
    data = File.read(File.expand_path('../../data/asher_mir_spec/ce.txt', __FILE__))
    FakeFS.activate!
    data
  }

  # Empty slot
  let(:ce_any_masterwork_variant) { Banshee44.roll_store[0].variants[3] }
  let(:ce_any_masterwork_gold) { 
    FakeFS.deactivate!
    data = File.read(File.expand_path('../../data/asher_mir_spec/ce_any_masterwork.txt', __FILE__))
    FakeFS.activate!
    data
  }

  # Multiple perks in nearly every slot
  let(:add_barrels_add_masterwork_variant) { Banshee44.roll_store[0].variants[4] }
  let(:add_barrels_add_masterwork_gold) { 
    FakeFS.deactivate!
    data = File.read(File.expand_path('../../data/asher_mir_spec/add_barrels_add_magazines.txt', __FILE__))
    FakeFS.activate!
    data
  }

  before(:example) do
    allow(Banshee44).to receive(:roll_store).and_return([roll])
  end

  describe '.generate_dim_wishlist' do
    
    context 'when there is basically one perk per slot' do
      it 'creates a wishlist' do
        expect(AsherMir.generate_dim_wishlist(ce_variant)).to eq(ce_gold)
      end
    end

    context 'when a slot has no perks specified' do
      it 'creates a wishlist' do
        expect(AsherMir.generate_dim_wishlist(ce_any_masterwork_variant)).to eq(ce_any_masterwork_gold)
      end
    end

    context 'when there are multiple perks in nearly every slot' do
      it 'creates a wishlist' do
        expect(AsherMir.generate_dim_wishlist(add_barrels_add_masterwork_variant)).to eq(add_barrels_add_masterwork_gold)
      end
    end
  end

end