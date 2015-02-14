class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :collection_id
      t.integer :template_id

      t.timestamps null: false
    end

    add_index :posts, :user_id
    add_index :posts, :collection_id
  end
end
