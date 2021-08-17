clearing :on
interactor :off

directories %w(data lib rolls spec) \
 .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$}) { 'spec' }
  watch(%r{^lib/(.+)\.rb$})     { 'spec' }
  watch(%r{^spec/data})         { 'spec' }
  watch(%r{^spec/fixtures})     { 'spec' }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rake, :task => 'generate_wishlist', :task_args => ['development'] do
  watch(%r{^data/(.+)\.yml$})
  watch(%r{^rolls/(.+)\.yml$})
end

guard :rake, :task => 'generate_website' do
  watch(%r{^data/(.+)\.yml$})
  watch(%r{^rolls/(.+)\.yml$})
end