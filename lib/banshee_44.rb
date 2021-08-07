class Banshee44

  def self.roll_store
    @@ROLL_STORE ||= populate_store
  end

  private

  def self.populate_store
    @@ROLL_STORE = []
    Dir['./roll_collections/**/*.yml'].each do |fn|
      rolls = YAML.load_file(fn)
      rolls.each do |r|
        @@ROLL_STORE << Roll.from_hash(r)
      end
    end
    @@ROLL_STORE
  end

end