# encoding: utf-8

FactoryGirl.define do
  factory :acts_as_metatags_meta_properties, class: 'ActsAsMetatags::MetaTags'do
    refresh 3
    new_property 'test'
  end

  factory :acts_as_metatags_meta_tag, class: 'ActsAsMetatags::MetaTags' do
    prefix 'ActsAsMetatags'
    separator ' | '
    suffix 'By Julio Antúnez Tarín'
    keywords 'ruby,rails,meta tags,metatags,meta_tags'
    description 'SEO MetaTags for Ruby On Rails'
    properties {}
    custom {}
  end

  factory :acts_as_metatags_meta_tag_empty, class: 'ActsAsMetatags::MetaTags' do
  end

  # factory :acts_as_metatags_meta_tag_with_properties, parent: :acts_as_metatags_meta_tag do
  #   properties { ActsAsMetatags::Properties.new({ refresh: 3, new_property: 'test' }) }
  # end
end
