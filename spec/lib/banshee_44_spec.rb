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

  let(:imperial_needle_yml) { <<-YML
-
  weapon_id: 3460122497
  name: GuiltySpark's Aggro Needle
  ratings_emoji: 😡
  tags: ['pvp']
  overview: >
    (copied from [Whispering Slab](https://rslifka.github.io/wishlist/#whispering-slab))   
  base_perks:
    barrels: [Elastic String]
    magazines: [Fiberglass Arrow Shaft]
    perks1: [Killing Wind]
    perks2: [Opening Shot]
    masterworks: [Accuracy MW, Draw Time MW]
  extended_perks:
    barrels: [Elastic String, Polymer String]
    magazines: [Fiberglass Arrow Shaft, Straight Fletching]
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
      FileUtils.mkdir_p('rolls/s13')
      FileUtils.mkdir_p('rolls/s14')
      File.write('./rolls/s13/imperial_needle.yml', imperial_needle_yml)
      File.write('./rolls/s14/chroma_rush.yml', chroma_rush_yml)
      File.write('./rolls/s14/sojourners_tale.yml', sojourners_tale_yml)
    end
  end

  describe '.roll_store' do
    let(:store) { Banshee44.roll_store }

    it 'provides access to rolls' do
      store.each do |roll|
        expect(roll).to be_a(Roll)
      end
    end

    it 'provides access to the proper number of rolls' do
      expect(store.length).to eq(5)
    end

    # We often need to compare wishlist output when making incremental changes
    # and having it be in a predictable order helps immensely with that
    it 'provides the rolls in alphbetical order by weapon name' do
      # Chroma Rush
      expect(store[0].name).to eq('Catching Fire')
      expect(store[0].weapon_id).to eq(1119734784)
      expect(store[1].name).to eq('Color Wheel')
      expect(store[1].weapon_id).to eq(1119734784)
      # Imperial Needle
      expect(store[2].name).to eq('GuiltySpark\'s Aggro Needle')
      expect(store[2].weapon_id).to eq(3460122497)
      # Sojourner's Tale
      expect(store[3].name).to eq('The Tale of Coolguy')
      expect(store[3].weapon_id).to eq(599895591)
      expect(store[4].name).to eq('Slugger\'s Choice')
      expect(store[4].weapon_id).to eq(599895591)
    end

  end

end