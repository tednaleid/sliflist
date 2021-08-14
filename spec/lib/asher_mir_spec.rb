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
      },
      []
    )
  }

  subject { AsherMir.new(roll) }

  before(:example) do
    allow(Banshee44).to receive(:roll_store).and_return([roll])
  end

  let(:variant_gold_data) {
    FakeFS.deactivate!
    gold_data = []
    (0..8).each do |i|
      gold_data << File.read(File.expand_path("../../data/asher_mir_spec/variant_#{i}.txt", __FILE__))
    end
    FakeFS.activate!
    gold_data
  }

  describe '#generate_wishlist' do
    it 'generates a wishlist comprised of all variant wishlists' do
      expect(subject.generate_wishlist).to eq(variant_gold_data.join("\n"))
    end
  end

  describe '#variant_wishlists' do

    it 'generates the right number of wishlists' do
      expect(subject.variant_wishlists.length).to eq(9)
    end

    it 'generates a wishlist for each variant' do
      (0..8).each do |i|
        expect(subject.variant_wishlists[i]).to eq(variant_gold_data[i])
      end
    end

  end

end