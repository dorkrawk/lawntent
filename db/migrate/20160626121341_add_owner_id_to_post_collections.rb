class AddOwnerIdToPostCollections < ActiveRecord::Migration
  def change
    add_column :post_collections, :owner_id, :integer
    add_index :post_collections, [:owner_id], :unique => true
  end
end
