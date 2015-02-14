class CreateFieldValues < ActiveRecord::Migration
  def change
    create_table :field_values do |t|
      t.integer :post_id
      t.integer :template_field_id
      t.string :field_type
      t.text :text_value
      t.string :string_value
      t.boolean :boolean_value

      t.timestamps null: false
    end

    add_index :field_values, :post_id
    add_index :field_values, :template_field_id
  end
end
