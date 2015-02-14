class CreatePostTemplates < ActiveRecord::Migration
  def change
    create_table :post_templates do |t|
      t.integer :post_collection_id
      t.string :title

      t.timestamps null: false
    end
  end
end
