class RenamePostsTemplateColumn < ActiveRecord::Migration
  def change
    rename_column :posts, :template_id, :post_template_id
  end
end
