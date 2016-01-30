class ChangeContentToJsonb < ActiveRecord::Migration
  def change
    remove_column :posts, :content
    add_column :posts, :content, :jsonb, :default => {}, :null => false
    add_index  :posts, :content, using: :gin
  end
end
