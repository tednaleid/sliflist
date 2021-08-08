class AsherMir

  def initialize(variant)
    @variant = variant
  end

  def wishlist
    results = StringIO.new
    results << "//notes:#{@variant.name}"
    results << "\n"
    results << entries.split("\n").sort.join("\n")
    results.string
  end

  def self.generate_dim_wishlist(variant)
    AsherMir.new(variant).wishlist
  end

  private

  # What perks are desired per slot? Build this intermediate structure so we
  # can generate rolls, consisting of a single choice per 'column'.
  # [
  #   [839105230],                      # B
  #   [3177308360],                     # M
  #   [2946784966],                     # P1
  #   [1015611457],                     # P2
  #   [150943607, 150943604, 150943605] # MW
  # ]
  def entries
    perk_ids = []
    %w(barrels magazines perks1 perks2 masterworks).each do |slot|
      # If the slot is empty, anything goes. No need to add to our structure.
      next if @variant.perks[slot].empty?
      perk_ids << @variant.perks[slot].map{|p| p.perk_ids}.flatten
    end
    StringIO.new.tap do |output|
      write_roll(output, perk_ids, [], 0)
    end.string
  end

  def write_roll(output, perk_ids, roll, row)
    if (row == perk_ids.length-1)
      perk_ids[row].each do |p|
        output.puts("dimwishlist:item=#{@variant.weapon_id}&perks=#{(roll+[p]).join(',')}")
      end
      return
    end
  
    perk_ids[row].each do |p|
      write_roll(output, perk_ids, roll + [p], row + 1)
    end
  end

end