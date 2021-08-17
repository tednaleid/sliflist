class Banshee44

  def self.roll_store
    @@ROLL_STORE ||= populate_store
  end

  # This is useful for generate the roll Markdown pages, since we need all the
  # rolls for a particular weapon.
  def self.roll_store_by_weapon_id
    roll_store.group_by{ |r| r.weapon.item_id }
  end

  def self.reboot
    @@ROLL_STORE = nil
  end

  private

  def self.populate_store
    @@ROLL_STORE = []
    
    # Using the basename (and not the full path) allows us to restructure this
    # area and still keep the same results (i.e. file weapons names don't
    # change even when their parent directories do).
    roll_files = Dir['./rolls/**/*.yml'].sort_by{|fn| File.basename(fn)}
    
    roll_files.each do |fn|
      rolls = YAML.load_file(fn)
      rolls.each do |r|
        @@ROLL_STORE << Roll.from_hash(r)
      end
    end
    
    @@ROLL_STORE
  end

end