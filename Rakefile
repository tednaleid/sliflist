$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

task :default => :spec