class CreateTemplateFields < ActiveRecord::Migration
  def change
    create_table :template_fields do |t|
      t.integer :post_template_id
      t.string :label
      t.string :field_type

      t.timestamps null: false
    end

    add_index :template_fields, :post_template_id
  end
end
