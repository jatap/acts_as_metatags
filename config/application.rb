# ActsAsMetatags - Application
#
# @author julio.antunez.tarin@gmail.com
#
module ActsAsMetatags
  class Application < Rails::Application

  # Use SQL instead of Active Record's schema dumper when creating the database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  config.active_record.schema_format = :sql

  # Automatically inject JavaScript needed for LiveReload
  config.middleware.insert_after(ActionDispatch::Static, Rack::LiveReload)

  # Replace console with Pry
  if defined?(Pry)
    silence_warnings do
      begin
          require 'pry'
          IRB = Pry
      rescue LoadError
      end
    end
  end

  end
end