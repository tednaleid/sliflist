class Variant

  attr_reader :weapon_id
  attr_reader :name
  attr_reader :perks

  def initialize(weapon_id, name, perks)
    @weapon_id = weapon_id
    @name = name
    @perks = perks
  end

end