describe Ada1 do

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

  describe '.from_id' do
    context 'when the ID is found' do
      it 'returns the weapon' do
        expect(Ada1.weapon_from_id(1097616550)).to be_a(Weapon)
        expect(Ada1.weapon_from_id(3856705927)).to be_a(Weapon)
      end
    end
    context 'when the ID is not found' do
      it 'errors out' do
        expect { Ada1.weapon_from_id(-1) }.to raise_error("Weapon w/ID '-1' not found in ./data/weapons/*.yml")
      end
    end
  end

end