class AddPagesToMetatags < ActiveRecord::Migration
  def up
    add_column :pages, :metatag_id, :integer
    add_index :pages, :metatag_id
  end

  def down
    remove_index :pages, :metatag_id
    remove_column :pages,  :metatag_id
  end
end
