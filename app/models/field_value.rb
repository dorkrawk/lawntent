class FieldValue < ActiveRecord::Base
  attr_accessible :post, :post_id, :template_field, :template_field_id, :field_type,
                    :text_value, :string_value, :boolean_value

  belongs_to :post, touch: true
  belongs_to :template_field
end
