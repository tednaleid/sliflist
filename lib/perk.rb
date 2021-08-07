class Perk
  
  attr_reader :name
  attr_reader :perk_ids

  def initialize(name, perk_ids)
    @name = name
    @perk_ids = perk_ids
  end

  def self.from_name(perk_name)
    raise "Perk '#{perk_name}'' not found in perk_ids.yml" unless get_perk_store()[perk_name]
    get_perk_store()[perk_name]
  end

  private

  @@PERK_STORE = {}

  def self.get_perk_store
    return @@PERK_STORE unless @@PERK_STORE.empty?

    perk_data = YAML.load_file('./data/perk_ids.yml')
    perk_data.each do |perk_name, perk_ids|
      ids = (perk_ids.is_a?(Array)) ? perk_ids : [perk_ids]
      @@PERK_STORE[perk_name] = Perk.new(perk_name, ids)
    end

    @@PERK_STORE
  end
end