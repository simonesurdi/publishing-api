class AddContentItemIndexes < ActiveRecord::Migration
  def change
    add_index :access_limits, :content_item_id
    add_index :linkables, :content_item_id
    add_index :states, :content_item_id
    add_index :translations, :content_item_id
  end
end
