class ChangeMetatagIdToMetaTagId < ActiveRecord::Migration
  def up
    rename_column :pages, :metatag_id, :meta_tag_id
  end

  def down
    rename_column :pages, :meta_tag_id, :metatag_id
  end
end
