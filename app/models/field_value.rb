class FieldValue < ActiveRecord::Base
  VALUE_FIELDS = {
    textblock: :text_value,
    text: :string_value,
    boolean: :boolean_value
  }

  attr_accessor :post, :post_id, :template_field, :template_field_id, :field_type,
                    :text_value, :string_value, :boolean_value

  belongs_to :post, touch: true
  belongs_to :template_field

  def value
    self.send(VALUE_FIELDS[field_type])
  end

  def self.field_types
    VALUE_FIELDS.keys
  end
end
