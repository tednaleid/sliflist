describe RollCollection do

  let(:data_hash) {
    {
      'weapon_id' => 1119734784,
      'name'     => 'Chasing Stability',
      'ratings_emoji' => '🏃‍♂️',
      'tags' => ['pve','pvp'],
      'overview' => 'Big time Stability roll',
      'base_perks' => {
        'barrels'     => ['Arrowhead Brake', 'Smallbore'],
        'magazines'   => ['Accelerated Coils', 'Accurized Rounds'],
        'perks1'      => ['Adrenaline Junkie', 'Ambitious Assassin'],
        'perks2'      => ['Auto-Loading Holster', 'Backup Plan'],
        'masterworks' => ['Impact MW', 'Blast Radius MW']
      },
      'extended_perks' => {
        'barrels'     => ['Arrowhead Brake', 'Smallbore'],
        'magazines'   => ['Accelerated Coils', 'Accurized Rounds'],
      }
    }
  }

  subject { RollCollection.from_hash(data_hash) }

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

      expect(b['barrels']).to match_array([Perk.from_name('Arrowhead Brake'),Perk.from_name('Smallbore')])
      expect(b['magazines']).to match_array([Perk.from_name('Accelerated Coils'),Perk.from_name('Accurized Rounds')])
      expect(b['perks1']).to match_array([Perk.from_name('Adrenaline Junkie'),Perk.from_name('Ambitious Assassin')])
      expect(b['perks2']).to match_array([Perk.from_name('Auto-Loading Holster'),Perk.from_name('Backup Plan')])
      expect(b['masterworks']).to match_array([Perk.from_name('Impact MW'),Perk.from_name('Blast Radius MW')])
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
end