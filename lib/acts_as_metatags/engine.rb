# ActsAsMetatags
#
# @author julio.antunez.tarin@gmail.com
#
module ActsAsMetatags
  # Engine
  #
  # @see Rails::Engine
  class Engine < ::Rails::Engine
    isolate_namespace ActsAsMetatags

    # Generators
    config.generators do |g|
      g.test_framework      :rspec,        fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets              false
      g.helper              false
      g.view_specs          false
      g.helper_specs        false
      g.routing_specs       false
      g.controller_specs    true
      g.request_specs       false
    end

    # Enable decorators
    config.to_prepare do
      Dir['app/decorators/**/*.rb'].each do |path|
        load path
      end
    end
  end
end
