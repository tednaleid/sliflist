class Ada1

  @@WEAPON_STORE = {}

  def self.weapon_from_id(weapon_id)
    return weapon_store[weapon_id] if weapon_store[weapon_id]
    raise "Weapon w/ID '#{weapon_id}' not found in ./data/weapons/*.yml"
  end

  def self.reboot
    @@WEAPON_STORE = {}
  end

  private

  def self.weapon_store
    return @@WEAPON_STORE unless @@WEAPON_STORE.empty?
    puts '[Ada1] Loading weapon database'
    Dir['./data/weapons/*.yml'].sort.each do |fn|
      puts "  > #{fn}"
      w = Weapon.from_hash(YAML.load_file(fn))
      @@WEAPON_STORE[w.item_id] = w
    end
    @@WEAPON_STORE
  end

end