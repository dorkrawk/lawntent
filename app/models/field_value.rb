class FieldValue < ActiveRecord::Base
  VALUE_FIELDS = {
    textblock: :text_value,
    text: :string_value,
    boolean: :boolean_value
  }

  belongs_to :post, touch: true
  belongs_to :template_field

  def value
    self.send(VALUE_FIELDS[field_type.to_sym])
  end

  def self.field_types
    VALUE_FIELDS.keys
  end
end
