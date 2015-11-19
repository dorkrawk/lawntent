class TemplateField < ActiveRecord::Base

  FIELD_TYPES = OpenStruct.new(
    textblock: 'Textblock',
    text: 'Text',
    boolean: 'Boolean',
    image: 'Image'
  )

  INPUT_TYPES = {
    textblock: :text,
    text: :string,
    boolean: :boolean
  }

  belongs_to :post_template
end
