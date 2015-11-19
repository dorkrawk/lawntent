class TemplateField < ActiveRecord::Base

  FIELD_TYPES = {
    textblock: 'Textblock',
    text: 'Text',
    boolean: 'Boolean',
    image: 'Image'
  }

  belongs_to :post_template

  def characteristics
    self.class.const_get("#{FIELD_TYPES[field_type.to_sym]}Field")
  end
end
