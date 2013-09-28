require 'activerecord-postgres-hstore'
require 'hstore_accessor'
require 'action_controller'
require 'action_view'

require 'acts_as_metatags/config'
require 'acts_as_metatags/engine'
require 'acts_as_metatags/tags'

# ActsAsMetatags
#
# @author julio.antunez.tarin@gmail.com
#
module ActsAsMetatags
end

# ActionView::Base.send :include, ActsAsMetatags::ViewHelper
# ActionController::Base.send :include, ActsAsMetatags::ControllerHelper
