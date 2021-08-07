class Ada1

  def self.weapon_store
    @@WEAPON_STORE ||= populate_weapon_store
  end

  private

  def self.populate_weapon_store
    Dir['./data/weapons/*.yml'].map{|fn| Weapon.from_hash(YAML.load_file(fn))}
  end

end