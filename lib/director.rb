class Director

  NICE_PERK_NAMES = {
    'barrels' => 'Barrels',
    'magazines' => 'Magazines',
    'perks1' => 'Perks 1',
    'perks2' => 'Perks 2',
    'masterworks' => 'Masterworks'
  }

  TOML_PREAMBLE = <<-TOML

[[docs]]
  name = "Welcome"
  weight = 1
  identifier = "welcome"
  url = "/docs/welcome/"

[[main]]
  name = "Rolls"
  url = "/docs/welcome/introduction/"
  weight = 10

[[social]]
  name = "GitHub"
  pre = "<svg xmlns=\\"http://www.w3.org/2000/svg\\" width=\\"20\\" height=\\"20\\" viewBox=\\"0 0 24 24\\" fill=\\"none\\" stroke=\\"currentColor\\" stroke-width=\\"2\\" stroke-linecap=\\"round\\" stroke-linejoin=\\"round\\" class=\\"feather feather-github\\"><path d=\\"M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22\\"></path></svg>"
  url = "https://github.com/rslifka/sliflist"
  post = "v0.1.0"
  weight = 20

[[footer]]
  name = "© 2021 Rob Slifka"
TOML

  def self.write_dim_wishlist(filename)
    wishlist = Banshee44.roll_store.map{|r| AsherMir.new(r).generate_wishlist }.join("\n")
    File.write(filename, wishlist)
  end

  def self.write_hugo_site
    write_menus_toml
    create_content_directories
    create_content_indices
    write_weapon_rolls
  end

  private

  def self.write_menus_toml
    puts '[Director] Writing menus.toml' if ENV['CI']
    weapon_ids = Banshee44.roll_store.map{|r| r.weapon.item_id}.uniq
    drop_sources = weapon_ids.map{|wid| Ada1.weapon_from_id(wid)}.map{|w| w.drop_source}.uniq
    sorted_sources = DropSource.source_ordering.select{|ds| drop_sources.include?(ds)}
    
    results = StringIO.new
    sorted_sources.each_with_index do |s,i|
      results.puts
      results.puts("[[docs]]")
      results.puts("  name = \"#{s.name}\"")
      results.puts("  weight = #{i+2}")
      results.puts("  identifier = \"#{s.source_id}\"")
      results.puts("  url = \"/docs/#{s.source_id}/\"")
    end
    results << TOML_PREAMBLE

    File.write('./hugo_site/config/_default/menus.toml', results.string)
  end

  def self.create_content_directories
    puts '[Director] Creating content directories' if ENV['CI']
    weapon_ids = Banshee44.roll_store.map{|r| r.weapon.item_id}.uniq
    drop_sources = weapon_ids.map{|wid| Ada1.weapon_from_id(wid)}.map{|w| w.drop_source}.uniq
    
    drop_sources.each do |ds|
      puts "  > ./hugo_site/content/docs/#{ds.source_id}" if ENV['CI']
      FileUtils.mkdir_p("./hugo_site/content/docs/#{ds.source_id}")
    end
  end

  def self.create_content_indices
    puts '[Director] Creating content indices' if ENV['CI']
    weapon_ids = Banshee44.roll_store.map{|r| r.weapon.item_id}.uniq
    drop_sources = weapon_ids.map{|wid| Ada1.weapon_from_id(wid)}.map{|w| w.drop_source}.uniq
      
    drop_sources.each do |ds|
      contents = <<-TXT
---
title: "#{ds.name}"
draft: false
---
TXT
      puts "  > /hugo_site/content/docs/#{ds.source_id}/_index.md" if ENV['CI']
      File.write("./hugo_site/content/docs/#{ds.source_id}/_index.md", contents)
    end
  end

  def self.write_weapon_rolls
    puts '[Director] Creating weapon \'docs\'' if ENV['CI']
    Banshee44.roll_store_by_weapon_id.each do |weapon_id, rolls|
      w = Ada1.weapon_from_id(weapon_id)

      result = StringIO.new
      result.puts <<-TXT
---
title: "#{w.name}"
draft: false
menu:
  docs:
    parent: "#{w.drop_source.source_id}"
toc: true
---
TXT

      d2g = "https://d2gunsmith.com/w/#{weapon_id}"
      lgg = "https://www.light.gg/db/items/#{weapon_id}"
      dtr = "https://destinytracker.com/destiny-2/db/items/#{weapon_id}"
      result.puts
      result.puts <<-TXT
For complete perks, see [d2gunsmith.com](#{d2g}), [light.gg](#{lgg}) or [destinytracker.com](#{dtr}).
TXT

      result.puts
      result.puts(w.overview)

      if w.has_pvp_comments?
        result.puts
        result.puts('## PvP Thoughts')
        result.puts
        result.puts(w.pvp_comments)
      end

      if w.has_pve_comments?
        result.puts
        result.puts('## PvE Thoughts')
        result.puts
        result.puts(w.pve_comments)
      end

      # Outputs *per roll* in the order they come from Banshee44
      rolls.each do |roll|
        
        # Name
        result.puts
        result.puts("## #{roll.ratings_emoji} #{roll.name} (#{roll.tags.join(',')})")
        
        # Overview
        result.puts
        result.puts(roll.overview)
        
        # Base perks
        result.puts
        result.puts('**Collector\'s Edition Roll**')
        %w(barrels magazines perks1 perks2 masterworks).each do |perk_slot_name|
          next unless roll.has_base_perks_for_slot?(perk_slot_name)
          perk_list = roll.base_perks[perk_slot_name].map{|p|p.name}.join(', ')
          result.puts("* **#{NICE_PERK_NAMES[perk_slot_name]}**: #{perk_list}")
        end

        # Extended perks
        if roll.has_extended_perks?
          result.puts
          result.puts('**Extended Perks** (referred to with a \'+\' below)')
          %w(barrels magazines perks1 perks2 masterworks).each do |perk_slot_name|
            next unless roll.has_extended_perks_for_slot?(perk_slot_name)
            perk_list = roll.extended_perks[perk_slot_name].map{|p|p.name}.join(', ')
            result.puts("* **#{NICE_PERK_NAMES[perk_slot_name]}**: #{perk_list}")
          end
        end
        
        # Variants
        result.puts
        result.puts('| Variant | Chance | 1 in ? |')
        result.puts('|:-|-:|-:|')
        roll.variants.each do |v|
          result.puts("| %s | %0.2f%% | %d |" % [v.base_name, v.probability(), v.average_rolls_required])
        end

      end
      
      filename = w.name.downcase.gsub(/[\ -]/, '_').gsub(/['\(\)]/,'')
      puts "  > ./hugo_site/content/docs/#{w.drop_source.source_id}/#{filename}.md" if ENV['CI']
      File.write("./hugo_site/content/docs/#{w.drop_source.source_id}/#{filename}.md", result.string)
    end
  end

end
