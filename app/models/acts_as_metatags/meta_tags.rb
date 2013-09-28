# ActsAsMetatags
#
# @author julio.antunez.tarin@gmail.com
#
module ActsAsMetatags
  # MetaTags Model.
  #
  # @see ActiveRecord::Base
  class MetaTags < ActiveRecord::Base
    attr_accessible :prefix, :separator, :suffix,
                    :description, :keywords,
                    :properties, :custom

    # HStore attributes: Properties
    serialize :properties, ActiveRecord::Coders::Hstore
    hstore_accessor :properties, ActsAsMetatags.properties_accessors_definition

    # HStore attributes: Custom
    serialize :custom, ActiveRecord::Coders::Hstore
    hstore_accessor :custom, ActsAsMetatags.custom_accessors_definition

    # Pages
    has_many :pages, inverse_of: :meta_tag, dependent: :destroy, uniq: true,
                     foreign_key: 'meta_tag_id'
    accepts_nested_attributes_for :pages, allow_destroy: true
    attr_accessible :pages_attributes

    # Validations

    # Callbacks
    before_create :set_defaults

    # To string representation of model.
    #
    # @return [String] the description
    def to_s
      self.description ||= id
    end

    # URL string representation of model.
    #
    # @return [String] the description
    def to_param
      to_s
    end

    # Page title.
    #
    # Combines prefix, separator and suffix.
    #
    # @return [String] the title
    def title
      "#{prefix}#{separator}#{suffix}"
    end

    # Configuration.
    #
    # Alias to module configuration.
    #
    # @return [ActsAsMetatags::Configuration] the module configuration
    def config
      ActsAsMetatags.config
    end

    # Set defaults.
    #
    # Add defaults to empty values from configuration.
    #
    # @return [String] the title
    def set_defaults
      build_attributes_hash.each do |attr, value|
        send("#{attr}=", config.send(attr)) if send(attr).blank?
      end
      build_hstore_attributes_defaults.each do |attr, value|
        send("#{attr}=", value) if send(attr).blank?
      end
    end

    # Build attributes hash (symbolized).
    #
    # Get value from configuration.
    #
    # @return [Hash] the attributes hash
    def build_attributes_hash
      attributes.symbolize_keys.except(:id, :properties, :custom, :created_at,
                                       :updated_at)
    end
    private :build_attributes_hash

    # Build hstore attributes hash (symbolized).
    #
    # Get collection value from hstore attribute configuration.
    #
    # @return [Hash] the attributes hash
    def build_hstore_attributes_defaults
      hstore_properties = ActsAsMetatags::Properties.new.to_hash
      hstore_custom = ActsAsMetatags::Custom.new.to_hash
      hstore_properties.deep_merge(hstore_custom)
    end
    private :build_hstore_attributes_defaults
  end
end