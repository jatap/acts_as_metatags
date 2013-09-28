# RSpec
begin
  require 'rspec/core'
  require 'rspec/core/rake_task'

  desc 'Run all specs in spec directory (excluding plugin specs)'
  RSpec::Core::RakeTask.new(spec: 'app:db:test:prepare')

  task default: :spec
rescue LoadError
  warn 'Rake Spec (app:db:test:prepare) not available.'
end
