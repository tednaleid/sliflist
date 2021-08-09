clearing :on
interactor :off

directories %w(lib rolls spec) \
 .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$}) { 'spec' }
  watch(%r{^lib/(.+)\.rb$})     { 'spec' }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rake, :task => 'generate_wishlist', :task_args => ['development'] do
  watch(%r{^rolls/(.+)\.yml$})
end