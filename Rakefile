$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'wishlist'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

task :generate_wishlist, [:environment] do |t, args|
  filename = (args.environment == 'development') ? 'wishlist.dev.txt' : 'wishlist.txt'
  puts '[Director] Generating wishlist...'
  Director.write_dim_wishlist(filename)
  puts '[Director] Done'
end

task :default => :spec