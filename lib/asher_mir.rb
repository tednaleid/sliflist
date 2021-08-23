class AsherMir

  def initialize(roll)
    @roll = roll
  end

  def generate_wishlist
    variant_wishlists.join("\n")
  end

  def variant_wishlists
    results = []
    @roll.variants.each do |v|
      results << wishlist(v)
    end
    results
  end

  private

  def wishlist(variant)
    results = StringIO.new
    results << "//notes:#{variant.name} (#{'%.3f' % variant.probability}%)"
    results << "\n"
    results << entries(variant).split("\n").sort.join("\n")
    results.string
  end

  # What perks are desired per slot? Build this intermediate structure so we
  # can generate rolls, consisting of a single choice per 'column'.
  # [
  #   [839105230],                      # B
  #   [3177308360],                     # M
  #   [2946784966],                     # P1
  #   [1015611457],                     # P2
  #   [150943607, 150943604, 150943605] # MW
  # ]
  def entries(variant)
    perk_ids = []
    %w(barrels magazines perks1 perks2 masterworks).each do |slot|
      # If the slot is empty, anything goes. No need to add to our structure.
      next if variant.perks[slot].empty?
      perk_ids << variant.perks[slot].map{|p| p.perk_ids}.flatten
    end
    StringIO.new.tap do |output|
      write_roll(output, perk_ids, [], 0)
    end.string
  end

  def write_roll(output, perk_ids, roll, row)
    if (row == perk_ids.length-1)
      perk_ids[row].each do |p|
        output.puts("dimwishlist:item=#{@roll.weapon.item_id}&perks=#{(roll+[p]).join(',')}")
      end
      return
    end
  
    perk_ids[row].each do |p|
      write_roll(output, perk_ids, roll + [p], row + 1)
    end
  end

end