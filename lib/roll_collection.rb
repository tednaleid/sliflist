class RollCollection

  attr_reader :weapon_id
  attr_reader :name
  attr_reader :ratings_emoji
  attr_reader :tags
  attr_reader :overview
  attr_reader :base_perks
  attr_reader :extended_perks

  def initialize(weapon_id, name, emoji, tags, overview, base_perks, extended_perks)
    @weapon_id = weapon_id
    @name = name
    @ratings_emoji = emoji
    @tags = tags
    @overview = overview
    @base_perks = base_perks
    @extended_perks = extended_perks
  end

  def self.from_hash(data_hash)
    base_perks = {}
    data_hash['base_perks'].each do |perk_slot_name, desired_perk_names|
      base_perks[perk_slot_name] = desired_perk_names.map{|n| Perk.from_name(n)}
    end

    extended_perks = {}
    data_hash['extended_perks'].each do |perk_slot_name, desired_perk_names|
      extended_perks[perk_slot_name] = desired_perk_names.map{|n| Perk.from_name(n)}
    end

    RollCollection.new(
      data_hash['weapon_id'],
      data_hash['name'],
      data_hash['ratings_emoji'],
      data_hash['tags'],
      data_hash['overview'],
      base_perks,
      extended_perks
    )
  end

end