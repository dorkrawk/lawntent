class TemplateField < ActiveRecord::Base
  attr_accessor :label, :field_type, :post_template, :post_template_id

  has_many :field_values
  belongs_to :post_template
end
