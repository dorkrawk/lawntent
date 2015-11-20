class AddDescriptorFieldToPostTemplate < ActiveRecord::Migration
  def change
    add_column :post_templates, :descriptor_field_id, :integer
  end
end
