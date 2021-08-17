class Variant

  attr_reader :weapon
  attr_reader :base_name
  attr_reader :name
  attr_reader :perks

  def initialize(weapon, wishlist_txt_name, base_name, perks)
    @weapon = weapon
    @name = wishlist_txt_name
    @base_name = base_name
    @perks = perks
  end

  def probability
    columnar_probabilities = []

    perks.each do |slot_name, perks|
      good_perks = perks.length
      total_perks = weapon.perk_slots[slot_name].possible_perk_count
      available_slots = weapon.perk_slots[slot_name].slot_count

      columnar_probabilities << column_probability(good_perks, total_perks, available_slots)
    end

    columnar_probabilities.reduce(:*) * 100
  end

  def average_rolls_required
    1 / probability() * 100
  end

  private

  def column_probability(good_perks, total_perks, available_slots)
    # No good perks means everything is acceptable
    return 1.0 if good_perks == 0
    
    # More slots than there are bad perks?
    return 1.0 if (available_slots + good_perks > total_perks)
        
    total = Probability.combinations(total_perks, available_slots)
    bad   = Probability.combinations(total_perks - good_perks, available_slots)
    (total - bad) / total
  end

end