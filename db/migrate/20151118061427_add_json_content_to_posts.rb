class AddJsonContentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :content, :json, null: false, default: '{}'
  end
end
