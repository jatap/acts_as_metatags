# encoding: utf-8

$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'acts_as_metatags/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'acts_as_metatags'
  s.version     = ActsAsMetatags::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2013-09-26'
  s.licenses    = ['MIT']
  s.authors     = ['Julio Antúnez Tarín']
  s.email       = 'julio.antunez.tarin@gmail.com'
  s.homepage    = 'http://twitter.com/jatap'
  s.summary     = 'SEO Meta Tags por Rails.'
  s.description = 'SEO Meta Tags for Rails.'

  s.files       = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files  = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 3.2.14'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'virtus'
  s.add_dependency 'friendly_id', '~> 4.0.10.1'
  s.add_dependency 'activerecord-postgres-hstore'
  s.add_dependency 'hstore_accessor'
  s.add_dependency 'awesome_nested_set'

  s.add_development_dependency 'pg'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-nc'
  s.add_development_dependency 'rspec-abhakungszeichen-formatter'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'nyan-cat-formatter'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'database_cleaner', '~> 1.0.1'
  s.add_development_dependency 'better_errors', '>= 0.7.2'
  s.add_development_dependency 'ruby_gntp'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'webrat'
  s.add_development_dependency 'spork-rails'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'brakeman'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rails', '>= 0.4.0'
  s.add_development_dependency 'guard-rspec', '>= 2.5.2'
  s.add_development_dependency 'guard-spork'
  s.add_development_dependency 'rack-livereload'
  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'guard-yard'
  s.add_development_dependency 'guard-brakeman'
  s.add_development_dependency 'guard-cane'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rails-erd'
  s.add_development_dependency 'cane'
  s.add_development_dependency 'debugger'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-doc'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-remote'
  s.add_development_dependency 'pry-remote-auto'
  s.add_development_dependency 'pry-debugger'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'colorize'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'bcrypt-ruby', '3.0.1'
  s.add_development_dependency 'strong_parameters'
  s.add_development_dependency 'passenger'
  s.add_development_dependency 'rails-erd'
  s.add_development_dependency 'rcodetools'
  s.add_development_dependency 'simplecov-gem-adapter'
  s.add_development_dependency 'rake'
end

