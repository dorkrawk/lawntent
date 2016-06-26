class AddSlugToPostCollections < ActiveRecord::Migration
  def change
    add_column :post_collections, :slug, :string
    add_index :post_collections, [:owner_id, :slug], :unique => true
  end
end
