describe Director do

  describe '.write_dim_wishlist' do
    
    let(:variant_gold_wishlist) {
      FakeFS.deactivate!
      gold_data = []
      (0..8).each do |i|
        gold_data << File.read(File.expand_path("../../data/asher_mir_spec/variant_#{i}.txt", __FILE__))
      end
      FakeFS.activate!
      gold_data.join("\n")
    }

    before(:example) do
      FileUtils.mkdir_p('rolls/s14')
      FileUtils.cp('./fixtures/rolls/chroma_rush.yml', 'rolls/s14')

      FileUtils.mkdir_p('data/weapons')
      FileUtils.cp('./fixtures/weapons/chroma_rush.yml', 'data/weapons')
    end

    it 'writes a wishlist' do
      Director.write_dim_wishlist('test_wishlist.txt')
      expect(File.read('test_wishlist.txt')).to eq(variant_gold_wishlist)
    end

  end

  describe '.write_hugo_site' do
    
    let(:menus_toml_gold) {
      FakeFS.deactivate!
      gold_data = File.read(File.expand_path("../../data/director_spec/menus.toml", __FILE__))
      FakeFS.activate!
      gold_data
    }

    let(:indices_gold) {
      gold_data = {}
      FakeFS.deactivate!
      gold_data['14'] = File.read(File.expand_path("../../data/director_spec/14_index.md", __FILE__))
      gold_data['ib'] = File.read(File.expand_path("../../data/director_spec/ib_index.md", __FILE__))
      gold_data['world'] = File.read(File.expand_path("../../data/director_spec/world_index.md", __FILE__))
      FakeFS.activate!
      gold_data
    }

    before(:example) do
      FakeFS do
        FileUtils.mkdir_p('rolls/iron_banner')
        FileUtils.cp('./fixtures/rolls/bite_of_the_fox.yml', 'rolls/iron_banner')
        FileUtils.mkdir_p('rolls/world_drops')
        FileUtils.cp('./fixtures/rolls/hung_jury_adept.yml', 'rolls/world_drops')
        FileUtils.cp('./fixtures/rolls/the_number.yml', 'rolls/world_drops')
        FileUtils.mkdir_p('rolls/s14')
        FileUtils.cp('./fixtures/rolls/chroma_rush.yml', 'rolls/s14')

        FileUtils.mkdir_p('data/weapons')
        FileUtils.cp('./fixtures/weapons/bite_of_the_fox.yml', 'data/weapons')
        FileUtils.cp('./fixtures/weapons/chroma_rush.yml', 'data/weapons')
        FileUtils.cp('./fixtures/weapons/hung_jury_adept.yml', 'data/weapons')
        FileUtils.cp('./fixtures/weapons/the_number.yml', 'data/weapons')

        FileUtils.mkdir_p('hugo_site/config/_default')
      end

      Director.write_hugo_site
    end

    it 'updates menus.toml' do
      expect(File.read('./hugo_site/config/_default/menus.toml')).to eq(menus_toml_gold)
    end

    it 'creates the docs directories for each drop source' do
      expect(Dir.exist?('./hugo_site/content/docs/14')).to be true
      expect(Dir.exist?('./hugo_site/content/docs/ib')).to be true
      expect(Dir.exist?('./hugo_site/content/docs/world')).to be true
    end

    it 'creates index pages for each drop source' do
      expect(File.exist?('./hugo_site/content/docs/14/_index.md')).to be true
      expect(File.exist?('./hugo_site/content/docs/ib/_index.md')).to be true
      expect(File.exist?('./hugo_site/content/docs/world/_index.md')).to be true

      expect(File.read('./hugo_site/content/docs/14/_index.md')).to eq(indices_gold['14'])
      expect(File.read('./hugo_site/content/docs/ib/_index.md')).to eq(indices_gold['ib'])
      expect(File.read('./hugo_site/content/docs/world/_index.md')).to eq(indices_gold['world'])
    end

    it 'creates roll files for each weapon' do
      expect(File.exist?('./hugo_site/content/docs/14/chroma_rush.md')).to be true
      expect(File.exist?('./hugo_site/content/docs/ib/bite_of_the_fox.md')).to be true
      expect(File.exist?('./hugo_site/content/docs/world/hung_jury_adept.md')).to be true
      expect(File.exist?('./hugo_site/content/docs/world/the_number.md')).to be true
    end
  end

end