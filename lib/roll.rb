class Roll

  attr_reader :weapon_id
  attr_reader :name
  attr_reader :ratings_emoji
  attr_reader :tags
  attr_reader :overview
  attr_reader :base_perks
  attr_reader :extended_perks

  STANDARD_VARIANT_PATTERNS = [
    '{emoji}{emoji}{emoji}🌟 Collector\'s Edition',
    '{emoji}{emoji}{emoji} CE (+barrels)',
    '{emoji}{emoji}{emoji} CE (+magazines)',
    '{emoji}{emoji}{emoji} CE (*masterworks)',
    '{emoji}{emoji} (+barrels, +magazines)',
    '{emoji}{emoji} (+barrels, *masterworks)',
    '{emoji}{emoji} (+magazines, *masterworks)',
    '{emoji}{emoji} (+barrels, +magazines, *masterworks)',
    '{emoji} (*barrels, *magazines, *masterworks)',
  ]

  def initialize(weapon_id, name, emoji, tags, overview, base_perks, extended_perks)
    @weapon_id = weapon_id
    @name = name
    @ratings_emoji = emoji
    @tags = tags
    @overview = overview
    @base_perks = base_perks
    @extended_perks = extended_perks
  end

  def variants
    STANDARD_VARIANT_PATTERNS.map do |pattern|
      name = "[#{tags.join(',')}] \"#{@name}\" #{pattern.gsub('{emoji}', @ratings_emoji)}"

      # Deep copy our baseline set of perks
      perks = Marshal.load(Marshal.dump(@base_perks))

      pattern.scan(/\.*\+(\w+)/) do |addition|
        perks[addition[0]] = @extended_perks[addition[0]]
      end

      pattern.scan(/\.*\*(\w+)/) do |wildcard|
        perks[wildcard[0]] = []
      end

      Variant.new(name, perks)
    end
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

    Roll.new(
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