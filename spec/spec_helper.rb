# Required so that we can use FakeFS
require 'pp'

# Many of our examples stub out the filesystem
require 'fakefs/spec_helpers'

# Entry point for our library
require 'wishlist'

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers

  config.before(:example) do
    FakeFS do
      Dir.mkdir('data')
      
      # Many of our specs require various Perk and Drop Source lookups, so we'll
      # copy these into our clean room before every example.
      #
      # These are static resources in the Destiny universe and once present,
      # will not change (e.g. Season 14 will exist in perpetuity).
      original_filename =  File.expand_path('../../data/perk_ids.yml', __FILE__)
      FakeFS::FileSystem.clone(original_filename, './data/perk_ids.yml')

      original_filename =  File.expand_path('../../data/drop_sources.yml', __FILE__)
      FakeFS::FileSystem.clone(original_filename, './data/drop_sources.yml')
    end
  end
end