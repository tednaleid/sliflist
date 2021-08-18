class Weapon

  attr_reader :name
  attr_reader :item_id
  attr_reader :drop_source
  attr_reader :perk_slots
  attr_reader :overview
  attr_reader :pvp_comments
  attr_reader :pve_comments

  def initialize(name, item_id, drop_source, perk_slots, overview, pvp_comments, pve_comments)
    @name = name
    @item_id = item_id
    @drop_source = drop_source
    @perk_slots = perk_slots
    @overview = overview
    @pvp_comments = pvp_comments
    @pve_comments = pve_comments
  end

  def has_pvp_comments?
    return false unless @pvp_comments
    !@pvp_comments.empty?
  end

  def has_pve_comments?
    return false unless @pve_comments
    !@pve_comments.empty?
  end

  def self.from_hash(data_hash)
    Weapon.new(
      data_hash['name'],
      data_hash['item_id'],
      DropSource.from_id(data_hash['drop_id']),
      PerkSlot.perk_slots_from_hash(data_hash['traits']),
      data_hash['overview'],
      data_hash['pvp_comments'],
      data_hash['pve_comments']
    )
  end

end