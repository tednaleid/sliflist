class PerkSlot

  PERK_SLOT_NAMES = [ 'barrels', 'magazines', 'perks1', 'perks2', 'masterworks' ]

  attr_reader :name
  attr_reader :slot_count
  attr_reader :possible_perk_count

  def initialize(name, possible_perk_count, slot_count)
    @name = name
    @slot_count = slot_count
    @possible_perk_count = possible_perk_count
  end

  def ==(other_obj)
    return @name == other_obj.name && 
      @slot_count == other_obj.slot_count && 
      @possible_perk_count == other_obj.possible_perk_count
  end

  def self.perk_slots_from_hash(data_hash)
    perk_slots = {}
    data_hash.each do |perk_name, slot_config|
      raise "'#{perk_name}' is not a valid perk slot name" unless PERK_SLOT_NAMES.include?(perk_name)
      perk_slots[perk_name] = PerkSlot.new(perk_name, slot_config['t'], slot_config['c'])
    end
    perk_slots
  end

end
