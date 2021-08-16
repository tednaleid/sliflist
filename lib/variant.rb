class Variant

  attr_reader :weapon
  attr_reader :name
  attr_reader :perks

  def initialize(weapon, name, perks)
    @weapon = weapon
    @name = name
    @perks = perks
  end

end