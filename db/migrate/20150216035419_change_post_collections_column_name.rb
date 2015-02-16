class ChangePostCollectionsColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :collection_id, :post_collection_id
  end
end
