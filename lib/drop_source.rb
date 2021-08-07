class DropSource
  
  attr_reader :name
  attr_reader :source_id

  def initialize(name, source_id)
    @name = name
    @source_id = source_id
  end

  def self.from_id(source_id)
    raise "Drop Source w/ID '#{source_id}' not found in drop_sources.yml" unless get_source_store()[source_id]
    get_source_store()[source_id]
  end

  def self.source_ordering
    @@DROP_SOURCE_ORDER
  end

  private

  @@DROP_SOURCE_STORE = {}
  @@DROP_SOURCE_ORDER = []

  def self.get_source_store
    return @@DROP_SOURCE_STORE unless @@DROP_SOURCE_STORE.empty?

    source_data = YAML.load_file('./data/drop_sources.yml')
    source_data.each do |source|
      source_id = source['id']
      source_name = source['name']
      @@DROP_SOURCE_STORE[source_id] = DropSource.new(source_name, source_id)
      @@DROP_SOURCE_ORDER << @@DROP_SOURCE_STORE[source_id]
    end

    @@DROP_SOURCE_STORE
  end
end