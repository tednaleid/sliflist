class Weapon

  attr_reader :name
  attr_reader :item_id
  attr_reader :drop_source
  attr_reader :perk_slots
  attr_reader :overview

  def initialize(name, item_id, drop_source, perk_slots, overview)
    @name = name
    @item_id = item_id
    @drop_source = drop_source
    @perk_slots = perk_slots
    @overview = overview
  end

  def self.from_hash(data_hash)
    Weapon.new(
      data_hash['name'],
      data_hash['item_id'],
      DropSource.from_id(data_hash['drop_id']),
      PerkSlot.perk_slots_from_hash(data_hash['traits']),
      data_hash['overview']
    )
  end

end