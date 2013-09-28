require 'spec_helper'

describe ActsAsMetatags::Properties do
  before { @properties = ActsAsMetatags::Properties.new }

  describe 'given expected attributes' do
    [:noindex,
     :nofollow,
     :canonical,
     :alternate,
     :pagination_prev,
     :pagination_next,
     :refresh,
     :redirect,
     :lowercase,
     :reverse].each do |expected_attribute|
      it 'responds to each of them' do
        expect(@properties).to respond_to expected_attribute
      end

      describe '#attributes' do
        it 'is a collection of previously declared attributes' do
          expect(@properties.attributes).to be_kind_of Hash
          expect(@properties.attributes).to have(10).items
        end
      end
    end
  end

  describe 'given unexpected attributes' do
    context 'with new added configuration' do
      before :each do
        @new_properties = ActsAsMetatags::Properties.new({ new_custom_attribute: 'Some value' })
      end

      it 'adds to attributes list' do
        expect(@new_properties.attributes).to include :new_custom_attribute
      end

      it 'creates an accessor' do
        expect(@new_properties.new_custom_attribute).to eq 'Some value'
      end
    end

    context 'without new configured attributes' do
      it 'throws and exception if attribute has not been previously configured' do
        expect { @properties.invalid_attribute }.to raise_error
      end
    end
  end
end

describe ActsAsMetatags::Custom do
  before { @custom = ActsAsMetatags::Custom.new }

  describe 'given expected attributes' do
    [:array_type,
     :hash_type,
     :og,
     :twitter_card].each do |expected_attribute|
      it 'responds to each of them' do
        expect(@custom).to respond_to expected_attribute
      end

      describe '#attributes' do
        it 'is a collection of previously declared attributes' do
          expect(@custom.attributes).to be_kind_of Hash
          expect(@custom.attributes).to have(4).items
        end
      end
    end
  end

  describe 'given unexpected attributes' do
    context 'with new added configuration' do
      before :each do
        @new_custom = ActsAsMetatags::Custom.new({ new_custom_attribute: 'Some value' })
      end

      it 'adds to attributes list' do
        expect(@new_custom.attributes).to include :new_custom_attribute
      end

      it 'creates an accessor' do
        expect(@new_custom.new_custom_attribute).to eq 'Some value'
      end
    end

    context 'without new configured attributes' do
      it 'throws and exception if attribute has not been previously configured' do
        expect { @properties.invalid_attribute }.to raise_error
      end
    end
  end
end

describe ActsAsMetatags::Configuration do
  let(:config) { ActsAsMetatags::Configuration.new }

  describe '.config' do
    it 'is active by default' do
      expect(config.active).to be
    end

    it 'is an alias to ActsAsMetatags.config' do
      config.active = true
      ActsAsMetatags.config.active = true
      expect(ActsAsMetatags.config.to_hash).to eq config.to_hash
    end
  end

  context '.configure' do
    before :each do
      ActsAsMetatags.configure do |config|
        config.properties = { new_amazing_key: 'sample value',
                              refresh: 10 }
        config.custom     = { another_amazing_key: 'another sample value' }
        config.custom.og  = { some: :value }
      end
    end

    context 'can be configured with a block' do
      let(:new_config) { ActsAsMetatags.config }

      it 'adding a new attribute to properties' do
        expect(new_config.properties.new_amazing_key).to eq 'sample value'
      end

      it 'adding an existant attribute o property' do
        expect(new_config.properties.refresh).to eq 10
      end

      it 'adding a new attribute to custom' do
        expect(new_config.custom.another_amazing_key).to eq 'another sample value'
      end

      it 'adding an existant attribute to custom' do
        expect(new_config.custom.og).to have(1).items
        expect(new_config.custom.og[:some]).to eq 'value'
      end
    end
  end

  context '.initialize_attributes' do
    let(:properties) { ActsAsMetatags::Properties.new({ sample: 'New amazing sample data', refresh: 15 }) }

    it 'adds a new attribute' do
      expect(properties.sample).to eq 'New amazing sample data'
    end

    it 'update existing attribute' do
      expect(properties.refresh).to eq 15
    end
  end

  context '.properties_accessors_definition' do
    before :each do
      ActsAsMetatags.configure do |config|
        config.properties = { new_amazing_key: 'sample value',
                              refresh: 15 }
      end
      ActsAsMetatags.properties_accessors_definition
      @config = ActsAsMetatags.config
    end

    it 'adds accesors to each config attribute' do
      expect(@config.properties.refresh).to eq 15
      expect(@config.properties.new_amazing_key).to eq 'sample value'
    end

    it 'admits settings as initializer' do
      properties = ActsAsMetatags::Properties.new({ refresh: 333, new_key: 'voila' })
      expect(properties.refresh).to eq 333
      expect(properties.new_key).to eq 'voila'
    end
  end

  context '.custom_accessors_definition' do
    before :each do
      ActsAsMetatags.configure do |config|
        config.custom     = { another_amazing_key: 'another sample value' }
        config.custom.og  = { some: :value }
      end
      ActsAsMetatags.custom_accessors_definition
      @config = ActsAsMetatags.config
    end

    it 'adds accesors to each config attribute' do
      expect(@config.custom.array_type).to eq []
      expect(@config.custom.another_amazing_key).to eq 'another sample value'
    end
  end
end
