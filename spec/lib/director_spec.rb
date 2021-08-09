describe Director do

  let(:chroma_rush_yml) { <<-YML
- 
  weapon_id: 1119734784
  name: Chasing Stability
  ratings_emoji: 🏃‍♂️
  tags: ['pve','pvp']
  overview: Big time Stability roll
  base_perks: 
    barrels: [Arrowhead Brake]
    magazines: [Steady Rounds]
    perks1: [Tunnel Vision]
    perks2: [Kill Clip]
    masterworks: [Range MW]
  extended_perks:
    barrels: [Arrowhead Brake, Polygonal Rifling]
    magazines: [Steady Rounds, Accurized Rounds]
YML
  }

  before(:example) do
    FakeFS do
      FileUtils.mkdir_p('rolls/s14')
      File.write('./rolls/s14/chroma_rush.yml', chroma_rush_yml)
    end
  end

  let(:variant_gold_wishlist) {
    FakeFS.deactivate!
    gold_data = []
    (0..8).each do |i|
      gold_data << File.read(File.expand_path("../../data/asher_mir_spec/variant_#{i}.txt", __FILE__))
    end
    FakeFS.activate!
    gold_data.join("\n")
  }

  describe '.write_dim_wishlist' do
    it 'writes a wishlist' do
      Director.write_dim_wishlist('test_wishlist.txt')
      expect(File.read('test_wishlist.txt')).to eq(variant_gold_wishlist)
    end
  end

end