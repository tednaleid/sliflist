describe 'Banshee' do

  let(:rendition_yml) { <<-YML
name: Extraordinary Rendition
item_id: 1097616550
drop_id: 13
traits:
  barrels:     {t: 9, c: 2}
  magazines:   {t: 7, c: 2}
  perks1:      {t: 6, c: 1}
  perks2:      {t: 6, c: 1}
  masterworks: {t: 4, c: 1}
overview: >
  Extraordinary Rendition is a 750 RPM Kinetic Submachine Gun; part of the S13
  weapon set. Both perks and stats are
YML
  }

  let(:hawkmoon_yml) { <<-YML
name: Hawkmoon
item_id: 3856705927
drop_id: world
traits:
  barrels:     {t: 9, c: 1}
  magazines:   {t: 1, c: 1}
  perks1:      {t: 9, c: 1}
  perks2:      {t: 5, c: 1}
  masterworks: {t: 1, c: 1}
overview: >
  Hawkmoon is a 140 RPM Exotic Hand Cannon, re-issued from Destiny 1 featuring
  random rolls! The base stats are terrific and it's hard to argue that any    
YML
  }

  before(:example) do
    FakeFS do
      FileUtils.mkdir_p('data/weapons')
      File.write('./data/weapons/extraordinary_rendition.yml', rendition_yml)
      File.write('./data/weapons/hawkmoon.yml', hawkmoon_yml)
    end
  end

  describe '.weapon_store' do
    let(:store) { Banshee.weapon_store }

    it 'provides access to the proper number of weapons' do
      expect(store.length).to eq(2)
    end 

    it 'provides the proper weapons' do
      store_sorted = Banshee.weapon_store.sort_by{|w| w.name}
      rendition = store_sorted[0]
      hawkmoon = store_sorted[1]

      expect(hawkmoon.name).to eq('Hawkmoon')
      expect(hawkmoon.item_id).to eq(3856705927)

      expect(rendition.name).to eq('Extraordinary Rendition')
      expect(rendition.item_id).to eq(1097616550)
    end  

  end

end