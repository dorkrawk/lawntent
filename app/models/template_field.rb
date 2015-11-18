class TemplateField < ActiveRecord::Base

  INPUT_TYPES = {
    textblock: :text,
    text: :string,
    boolean: :boolean
  }

  belongs_to :post_template
end
