describe AsherMir do

  before do
    FileUtils.mkdir_p('rolls/s14')
    FileUtils.cp('./fixtures/rolls/chroma_rush.yml', 'rolls/s14')

    FileUtils.mkdir_p('data/weapons')
    FileUtils.cp('./fixtures/weapons/chroma_rush.yml', 'data/weapons')
  end

  let(:roll) { Banshee44.roll_store[0] }

  subject { AsherMir.new(roll) }

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