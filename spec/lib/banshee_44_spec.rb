describe Banshee44 do

  let(:chroma_rush_yml) { <<-YML
- 
  weapon_id: 1119734784
  name: Catching Fire
  ratings_emoji: 🔥
  tags: ['pvp']
  overview: >
    With `Heating Up` and `Kill Clip` going, Chroma Rush feels like a
  base_perks: 
    barrels: [Smallbore]
    magazines: [Steady Rounds]
    perks1: [Heating Up]
    perks2: [Kill Clip]
    masterworks: [Stability MW]
  extended_perks:
    barrels: [Smallbore, Polygonal Rifling, Corkscrew Rifling, Fluted Barrel, Chambered Compensator, Arrowhead Brake]
    magazines: [Steady Rounds, Tactical Mag, Flared Magwell, Accurized Rounds]
-
  weapon_id: 1119734784
  name: Color Wheel
  ratings_emoji: 🎨
  tags: ['pvp']
  overview: >
    This is similar to the above roll, swapping out `Heating Up` in
  base_perks: 
    barrels: [Smallbore]
    magazines: [Steady Rounds]
    perks1: [Tunnel Vision]
    perks2: [Kill Clip]
    masterworks: [Stability MW]
  extended_perks:
    barrels: [Smallbore, Polygonal Rifling, Corkscrew Rifling, Fluted Barrel, Chambered Compensator, Arrowhead Brake]
    magazines: [Steady Rounds, Tactical Mag, Flared Magwell, Accurized Rounds]
YML
  }

  let(:sojourners_tale_yml) { <<-YML
- 
  weapon_id: 599895591
  name: The Tale of Coolguy
  ratings_emoji: 📖
  tags: ['pvp']
  overview: >
    Coolguy has a terrific
  base_perks: 
    barrels: [Fluted Barrel]
    magazines: [Assault Mag]
    perks1: [Tunnel Vision]
    perks2: [Killing Wind]
    masterworks: [Handling MW]
  extended_perks:
    barrels: [Fluted Barrel, Corkscrew Rifling, Hammer-Forged Rifling, Arrowhead Brake, Smallbore]
    magazines: [Assault Mag, Accurized Rounds, Light Mag]
-
  weapon_id: 599895591
  name: Slugger's Choice
  ratings_emoji: 🐌
  tags: ['pvp']
  overview: >
    Your standard set of "secure that first kill" perks.
  base_perks: 
    barrels: [Fluted Barrel]
    magazines: [Assault Mag]
    perks1: [Moving Target, Quickdraw, Threat Detector]
    perks2: [Opening Shot]
    masterworks: [Handling MW]
  extended_perks:
    barrels: [Fluted Barrel, Corkscrew Rifling, Hammer-Forged Rifling, Arrowhead Brake, Smallbore]
    magazines: [Assault Mag, Accurized Rounds, Light Mag]
YML
  }

  before(:example) do
    FakeFS do
      FileUtils.mkdir_p('rolls/s14')
      File.write('./rolls/s14/chroma_rush.yml', chroma_rush_yml)
      File.write('./rolls/s14/sojourners_tale.yml', sojourners_tale_yml)
    end
  end

  describe '.roll_store' do
    let(:store) { Banshee44.roll_store }

    it 'provides access to the proper number of weapons' do
      expect(store.length).to eq(4)
    end 

    it 'provides the proper roll collections' do
      store_sorted = store.sort_by{|w| "#{w.weapon_id}-#{w.name}"}

      ca_catching = store_sorted[0]
      ca_color = store_sorted[1]
      st_slugger = store_sorted[2]
      st_coolguy = store_sorted[3]

      expect(st_slugger.weapon_id).to eq(599895591)
      expect(st_slugger.name).to eq('Slugger\'s Choice')

      expect(st_coolguy.weapon_id).to eq(599895591)
      expect(st_coolguy.name).to eq('The Tale of Coolguy')

      expect(ca_catching.weapon_id).to eq(1119734784)
      expect(ca_catching.name).to eq('Catching Fire')

      expect(ca_color.weapon_id).to eq(1119734784)
      expect(ca_color.name).to eq('Color Wheel')
    end  

  end

end