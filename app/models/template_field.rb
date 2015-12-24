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

  def descriptor_field?
    id == post_template.descriptor_field_id
  end
end
