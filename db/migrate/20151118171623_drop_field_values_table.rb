class DropFieldValuesTable < ActiveRecord::Migration
  def change
    drop_table :field_values
  end
end
