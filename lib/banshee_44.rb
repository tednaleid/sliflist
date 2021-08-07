class Banshee44

  def self.roll_collections_store
    @@ROLL_COLLECTIONS_STORE ||= populate_store
  end

  private

  def self.populate_store
    @@ROLL_COLLECTIONS_STORE = []
    Dir['./roll_collections/**/*.yml'].each do |fn|
      roll_collections = YAML.load_file(fn)
      roll_collections.each do |rc|
        @@ROLL_COLLECTIONS_STORE << RollCollection.from_hash(rc)
      end
    end
    @@ROLL_COLLECTIONS_STORE
  end

end