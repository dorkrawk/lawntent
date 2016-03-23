class CreatePostImage < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.integer :post_id
      t.integer :template_field_id
      t.integer :image_width
      t.integer :image_height
      t.string :hover_text

      t.timestamps null: false
    end

    add_index :post_images, :post_id
    add_index :post_images, :template_field_id
  end
end
