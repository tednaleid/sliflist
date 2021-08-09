$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'wishlist'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

task :generate_wishlist do 
  puts 'Generating wishlist...'
  Director.write_dim_wishlist('wishlist.txt')
end

task :default => :spec