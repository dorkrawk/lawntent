class TemplateField < ActiveRecord::Base

  has_many :field_values
  belongs_to :post_template
end
