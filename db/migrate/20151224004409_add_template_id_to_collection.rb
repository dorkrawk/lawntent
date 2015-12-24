class AddTemplateIdToCollection < ActiveRecord::Migration
  def change
    add_column :post_collections, :post_template_id, :integer
    remove_column :post_templates, :post_collection_id
  end
end
