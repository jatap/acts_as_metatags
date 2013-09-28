require 'spec_helper'

describe ActsAsMetatags::Tags do
  context 'given a class inclusion' do
    before :each do
      @page = Page.new
    end

    context 'if config.active is not true' do
      it 'throws an exception' do
        expect do
          ActsAsMetatags.config.active = false
          Page.acts_as_metatags
        end.to raise_error(StandardError)
      end
    end

    describe '.acts_as_metatags_config' do
      it 'shows configuration object' do
        expect(Page.acts_as_metatags_config).to eq ActsAsMetatags.config
      end
    end

    context '#meta_tags?' do
      it 'shows its state(active or not)' do
        expect(@page.meta_tags?).to eq ActsAsMetatags.config.active
      end
    end

    context '#tags?' do
      it 'is a #meta_tags? alias' do
        expect(@page.meta_tags?).to eq @page.tags?
      end
    end

    context '#has_meta_tags?' do
      it 'is a #meta_tags? alias' do
        expect(@page.has_meta_tags?).to eq @page.meta_tags?
      end
    end

    describe 'given associated page' do
      context '#meta_tag_id' do
        before :each do
          @page.meta_tag = build(:acts_as_metatags_meta_tag)
          @page.save
        end

        it 'shows data' do
          expect(@page.meta_tag_id).to eq ActsAsMetatags::MetaTags.first.id
        end
      end
    end
  end
end
