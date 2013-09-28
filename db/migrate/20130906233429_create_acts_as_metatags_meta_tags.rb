class CreateActsAsMetatagsMetaTags < ActiveRecord::Migration
  def up
    create_table :acts_as_metatags_meta_tags do |t|
      t.string :prefix
      t.string :separator
      t.string :suffix
      t.text :keywords
      t.string :description
      t.hstore :properties
      t.hstore :custom

      t.timestamps
    end

    add_hstore_index :acts_as_metatags_meta_tags, :properties
    add_hstore_index :acts_as_metatags_meta_tags, :custom
  end

  def down
    remove_index :acts_as_metatags_meta_tags, :properties
    remove_index :acts_as_metatags_meta_tags, :custom
    drop_table :acts_as_metatags_meta_tags
  end
end
