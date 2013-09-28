# encoding: utf-8

require 'spec_helper'

# ActsAsMetatags.
#
# @author julio.antunez.tarin@gmail.com
#
module ActsAsMetatags
  describe MetaTags do
    before :each do
      @meta_tag = create(:acts_as_metatags_meta_tag)
    end

    describe 'given expected attributes' do
      [:prefix,
       :separator,
       :suffix,
       :keywords,
       :description,
       :properties,
       :custom,
       :pages].each do |expected_attribute|
        it { expect(@meta_tag).to respond_to expected_attribute }
      end
    end

    describe 'given initial state' do
      it 'is valid' do
        expect(@meta_tag).to be_valid
      end
    end

    describe '#to_s' do
      it 'shows :description' do
        expect(@meta_tag.to_s).to eq @meta_tag.description
      end
    end

    describe '#to_param' do
      it 'shows :description' do
        expect(@meta_tag.to_param).to eq @meta_tag.description
      end
    end

    describe '#title' do
      it 'combines prefix, separator and suffix' do
        expect(@meta_tag.title).to eq "ActsAsMetatags | By Julio Antúnez Tarín"
      end
    end

    describe '#pages' do
      context 'given elements' do
        let(:page) { Page.new(title: 'Home', content: 'Sample content text') }
        before :each do
          @meta_tag.pages << page
        end

        it 'are saved successfully' do
          expect(ActsAsMetatags::MetaTags.all.size).to eq 1
        end

        describe 'when page is deleted' do
          it 'are deleted too' do
            @meta_tag.pages.clear
            expect(Page.all.size).to eq 0
          end
        end

        it 'are unique by meta_tag' do
          @meta_tag.pages << page
          expect(@meta_tag.pages.size).to eq 1
        end
      end
    end

    describe '#config' do
      it 'is an alias to ActsAsMetatags.config' do
        expect(@meta_tag.config).to eq ActsAsMetatags.config
      end
    end

    context '#set_defaults' do
      before :each do
        @empty_meta_tag = create(:acts_as_metatags_meta_tag_empty)
      end

      it 'pupulate empty data with defaults from configuration' do
        expect(@empty_meta_tag.prefix).to eq @meta_tag.prefix
      end
    end

    describe '#properties' do
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
          it 'adds a new accesor for each hstore attribute' do
            expect(@meta_tag).to respond_to expected_attribute
          end
        end
      end

      it 'admits defauls values' do
        expect(@meta_tag.noindex).to be
        expect(@meta_tag.nofollow).to be
        expect(@meta_tag.canonical).to eq ''
        expect(@meta_tag.alternate).to eq ''
        expect(@meta_tag.pagination_prev).to eq ''
        expect(@meta_tag.pagination_next).to eq ''
        expect(@meta_tag.refresh).to eq 5
        expect(@meta_tag.redirect).to eq ''
        expect(@meta_tag.lowercase).to be
        expect(@meta_tag.reverse).to be
      end
    end

  end
end
