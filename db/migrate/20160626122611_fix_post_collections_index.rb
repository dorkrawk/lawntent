class FixPostCollectionsIndex < ActiveRecord::Migration
  def change
    remove_index :post_collections, :owner_id
  end
end
