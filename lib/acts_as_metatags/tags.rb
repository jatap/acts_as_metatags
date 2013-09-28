# ActsAsMetatags
#
# @author julio.antunez.tarin@gmail.com
#
module ActsAsMetatags
  # Tags
  #
  # @see ActiveSupport::Configurable
  module Tags
    extend ActiveSupport::Concern

    included do
    end

    # ClassMethods
    #
    # @return [void]
    module ClassMethods
      # Configuration inactive exception message
      EXC_INACTIVE = 'MetaTags is not active yet, configure it.'

      # Declares a class as metatags.
      #
      # @return [void]
      def acts_as_metatags(options = {})
        raise StandardError, EXC_INACTIVE unless ActsAsMetatags.config.active

        # Association
        belongs_to :meta_tag, inverse_of: :pages,
                              class_name: 'ActsAsMetatags::MetaTags'
        attr_accessible :meta_tag_id
      end

      # Get configuration object
      #
      # @return [ActsAsMetatags::Configuration] the configuration object
      def acts_as_metatags_config
        ActsAsMetatags.config
      end
    end

    # Flag to check if engine has been activated
    #
    # @return [Boolean] the active flag
    def meta_tags?
      ActsAsMetatags.config.active
    end
    alias_method :tags?, :meta_tags?
    alias_method :has_meta_tags?, :meta_tags?
  end
end

ActiveRecord::Base.send :include, ActsAsMetatags::Tags