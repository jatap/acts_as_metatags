require 'virtus'
require 'active_support/core_ext/hash/indifferent_access'

# ActsAsMetatags
#
# @author julio.antunez.tarin@gmail.com
#
module ActsAsMetatags

  # Default data.
  #
  # Feel free to add new constants.
  module Defaults
    # Flag active
    ACTIVE          = true
    # Prefix
    PREFIX          = 'ActsAsMetatags'
    # Separator
    SEPARATOR       = ' | '
    # Suffix
    SUFFIX          = 'By @jatap'
    # Keywords
    KEYWORDS        = 'ruby,rails,meta tags,metatags,meta_tags'
    # Description
    DESCRIPTION     = 'SEO MetaTags for Ruby On Rails'
    # Properties: noindex
    NOINDEX         = true
    # Properties: nofollow
    NOFOLLOW        = true
    # Properties: canonical
    CANONICAL       = ''
    # Properties: alternate
    ALTERNATE       = ''
    # Properties: pagination_prev
    PAGINATION_PREV = ''
    # Properties: pagination_next
    PAGINATION_NEXT = ''
    # Properties: refresh
    REFRESH         = 5
    # Properties: redirect
    REDIRECT        = ''
    # Properties: lowercase
    LOWERCASE       = true
    # Properties: reverse
    REVERSE         = true
    # Custom: array_type
    ARRAY_TYPE      = []
    # Custom: hash_type
    HASH_TYPE       = {}
    # Custom: og
    OG              = {}
    # Custom: twitter_card
    TWITTER_CARD    = {}
  end

  # Properties(hstore attributes).
  #
  # It admits new values but it's recommended to use Custom to add new extra
  # values.
  class Properties < ActiveSupport::HashWithIndifferentAccess
    include Virtus

    attribute :noindex,         Boolean, default: Defaults::NOINDEX
    attribute :nofollow,        Boolean, default: Defaults::NOFOLLOW
    attribute :canonical,       String,  default: Defaults::CANONICAL
    attribute :alternate,       String,  default: Defaults::ALTERNATE
    attribute :pagination_prev, String,  default: Defaults::PAGINATION_PREV
    attribute :pagination_next, String,  default: Defaults::PAGINATION_NEXT
    attribute :refresh,         Integer, default: Defaults::REFRESH
    attribute :redirect,        String,  default: Defaults::REDIRECT
    attribute :lowercase,       Boolean, default: Defaults::LOWERCASE
    attribute :reverse,         Boolean, default: Defaults::REVERSE

    # Initialize.
    #
    # @param  args [Hash] the parameters
    # @return [Properties] the instance
    def initialize(*args)
      ActsAsMetatags.initialize_attributes(*args, self)
    end
  end

  # Custom(hstore attributes).
  #
  # Add extra attributes here.
  class Custom < ActiveSupport::HashWithIndifferentAccess
    include Virtus

    attribute :array_type, Array, default: Defaults::ARRAY_TYPE
    attribute :hash_type, Hash[Symbol => String], default: Defaults::HASH_TYPE
    attribute :og, Hash[Symbol => String],  default: Defaults::OG
    attribute :twitter_card, Hash[Symbol => String],
              default: Defaults::TWITTER_CARD

    # Initialize.
    #
    # @param  args [Hash] the parameters
    # @return [Custom] the instance
    def initialize(*args)
      ActsAsMetatags.initialize_attributes(*args, self)
    end
  end

  # Initialize new store attributes.
  #
  # @param  args [Hash] the parameters
  # @param  instance [Properties|Custom] the instance
  #
  # @return [void]
  def self.initialize_attributes(*args, instance)
    unless args.blank?
      args.first.each do |k, v|
        instance.extend Virtus
        unless instance.attributes.include? k
          instance.attribute k, String, default: v
        end
      end
    end
  end

  # Configures global settings for ActsAsMetatags.
  #
  # @example Put this into an initializer
  #   ActsAsMetatags.configure do |config|
  #     config.duration = 3.days
  #   end
  # @return [ActsAsMetatags::Configuration] the configuration object
  def self.configure(&block)
    yield @config ||= ActsAsMetatags::Configuration.new
  end

  # Global settings for ActsAsMetatags.
  #
  # @return [ActsAsMetatags::Configuration] the configuration object
  def self.config
    @config ||= ActsAsMetatags::Configuration.new
  end

  # Build accesors for properties(hstore attribute)
  #
  # @return [Hash] the hash with attributes and data types, both are symbols
  def self.properties_accessors_definition
    config if @config.nil?
    hstore_accessors_definition_builder(:properties)
  end

  # Build accesors for custom(hstore attribute)
  #
  # @return [Hash] the hash with attributes and data types, both are symbols
  def self.custom_accessors_definition
    config if @config.nil?
    hstore_accessors_definition_builder(:custom)
  end

  # Build accesors for hstore attributes
  #
  # @param attribute [Symbol] the properties o custom list
  # @return [Hash] the hash with attributes and data types, both are symbols
  def self.hstore_accessors_definition_builder(attribute)
    return ActiveSupport::HashWithIndifferentAccess.new if @config.nil?
    @config.send("#{attribute.to_s}").to_hash.reduce({}) do |memo, (k, v)|
      if [TrueClass, FalseClass].include? v.class
        memo[k.to_sym] = :boolean
      elsif [Fixnum].include? v.class
        memo[k.to_sym] = :integer
      else
        memo[k.to_sym] = v.class.to_s.downcase.to_sym
      end
      memo
    end
  end

  # Configuration with accessors
  #
  # @see Virtus
  class Configuration
    include Virtus

    attribute :active,      Boolean,    default: Defaults::ACTIVE
    attribute :prefix,      String,     default: Defaults::PREFIX
    attribute :separator,   String,     default: Defaults::SEPARATOR
    attribute :suffix,      String,     default: Defaults::SUFFIX
    attribute :keywords,    String,     default: Defaults::KEYWORDS
    attribute :description, String,     default: Defaults::DESCRIPTION
    # HStore attributes
    attribute :properties,  Properties, default: Properties.new
    attribute :custom,      Custom,     default: Custom.new

    alias_method :config, :attributes
    alias_method :config=, :attributes=
  end
end
