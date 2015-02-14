class CreatePostCollections < ActiveRecord::Migration
  def change
    create_table :post_collections do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
