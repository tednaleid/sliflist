describe Roll do

  let(:data_hash) {
    {
      'weapon_id' => 1119734784,
      'name'     => 'Chasing Stability',
      'ratings_emoji' => '🏃‍♂️',
      'tags' => ['pve','pvp'],
      'overview' => 'Big time Stability roll',
      'base_perks' => {
        'barrels'     => ['Arrowhead Brake'],
        'magazines'   => ['Accelerated Coils'],
        'perks1'      => ['Adrenaline Junkie'],
        'perks2'      => ['Auto-Loading Holster'],
        'masterworks' => ['Impact MW']
      },
      'extended_perks' => {
        'barrels'     => ['Arrowhead Brake', 'Smallbore'],
        'magazines'   => ['Accelerated Coils', 'Accurized Rounds'],
      }
    }
  }

  subject { Roll.from_hash(data_hash) }

  describe '#weapon_id' do
    it 'returns the weapon_id' do
      expect(subject.weapon_id).to eq(1119734784)
    end
  end

  describe '#name' do
    it 'returns the name' do
      expect(subject.name).to eq('Chasing Stability')
    end
  end

  describe '#overview' do
    it 'returns the overview' do
      expect(subject.overview).to eq('Big time Stability roll')
    end
  end

  describe '#ratings_emoji' do
    it 'returns the emoji used for variants' do
      expect(subject.ratings_emoji).to eq('🏃‍♂️')
    end
  end

  describe '#tags' do
    it 'returns the overview' do
      expect(subject.tags).to match_array(['pvp','pve'])
    end
  end

  describe '#base_perks' do
    it 'returns the perks the collection is based on' do
      b = subject.base_perks

      expect(b.length).to eq(5)

      expect(b['barrels']).to match_array([Perk.from_name('Arrowhead Brake')])
      expect(b['magazines']).to match_array([Perk.from_name('Accelerated Coils')])
      expect(b['perks1']).to match_array([Perk.from_name('Adrenaline Junkie')])
      expect(b['perks2']).to match_array([Perk.from_name('Auto-Loading Holster')])
      expect(b['masterworks']).to match_array([Perk.from_name('Impact MW')])
    end
  end

  describe '#extended_perks' do
    it 'returns the perks the collection is based on' do
      e = subject.extended_perks

      expect(e.length).to eq(2)

      expect(e['barrels']).to match_array([Perk.from_name('Arrowhead Brake'),Perk.from_name('Smallbore')])
      expect(e['magazines']).to match_array([Perk.from_name('Accelerated Coils'),Perk.from_name('Accurized Rounds')])
    end
  end

  describe '#variants' do
    let(:variants) { subject.variants }

    it 'returns the count' do
      expect(variants.length).to eq(9)
    end

    it 'sets the weapon IDs' do
      variants.each do |v|
        expect(v.weapon_id).to eq(1119734784)
      end
    end

    it 'returns variant names' do
      expect(variants[0].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️🏃‍♂️🌟 Collector\'s Edition')
      expect(variants[1].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️🏃‍♂️ CE (+barrels)')
      expect(variants[2].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️🏃‍♂️ CE (+magazines)')
      expect(variants[3].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️🏃‍♂️ CE (*masterworks)')
      expect(variants[4].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️ (+barrels, +magazines)')
      expect(variants[5].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️ (+barrels, *masterworks)')
      expect(variants[6].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️ (+magazines, *masterworks)')
      expect(variants[7].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️🏃‍♂️ (+barrels, +magazines, *masterworks)')
      expect(variants[8].name).to eq('[pve,pvp] "Chasing Stability" 🏃‍♂️ (*barrels, *magazines, *masterworks)')
    end

    it 'configures the variants' do
      # 🏃‍♂️🏃‍♂️🏃‍♂️🌟 Collector's Edition
      expect(variants[0].perks).to include({
        'barrels'     => [Perk.from_name('Arrowhead Brake')],
        'magazines'   => [Perk.from_name('Accelerated Coils')],
        'perks1'      => [Perk.from_name('Adrenaline Junkie')],
        'perks2'      => [Perk.from_name('Auto-Loading Holster')],
        'masterworks' => [Perk.from_name('Impact MW')]
      })

      # 🏃‍♂️🏃‍♂️🏃‍♂️🌟 CE (+barrels)
      expect(variants[1].perks).to include({
        'barrels'     => [Perk.from_name('Arrowhead Brake'), Perk.from_name('Smallbore')],
        'magazines'   => [Perk.from_name('Accelerated Coils')],
        'perks1'      => [Perk.from_name('Adrenaline Junkie')],
        'perks2'      => [Perk.from_name('Auto-Loading Holster')],
        'masterworks' => [Perk.from_name('Impact MW')]
      })

      # 🏃‍♂️🏃‍♂️🏃‍♂️🌟 CE (*masterworks)
      expect(variants[3].perks).to include({
        'barrels'     => [Perk.from_name('Arrowhead Brake')],
        'magazines'   => [Perk.from_name('Accelerated Coils')],
        'perks1'      => [Perk.from_name('Adrenaline Junkie')],
        'perks2'      => [Perk.from_name('Auto-Loading Holster')],
        'masterworks' => []
      })

      # 🏃‍♂️🏃‍♂️ (+barrels, +magazines, *masterworks)
      expect(variants[7].perks).to include({
        'barrels'     => [Perk.from_name('Arrowhead Brake'), Perk.from_name('Smallbore')],
        'magazines'   => [Perk.from_name('Accelerated Coils'), Perk.from_name('Accurized Rounds')],
        'perks1'      => [Perk.from_name('Adrenaline Junkie')],
        'perks2'      => [Perk.from_name('Auto-Loading Holster')],
        'masterworks' => []
      })
    end
  end
end