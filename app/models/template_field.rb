class TemplateField < ActiveRecord::Base

  has_many :field_values
  belongs_to :post_template

  def get_new_field_value
    FieldValue.new(template_field: self, field_type: self.field_type)
  end

  def value_field
    FieldValue::VALUE_FIELDS[field_type.to_sym]
  end
end
