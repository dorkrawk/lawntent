class TemplateField < ActiveRecord::Base

  FIELD_TYPES = {
    textblock: 'Textblock',
    text: 'Text',
    boolean: 'Boolean',
    image: 'Image'
  }

  belongs_to :post_template

  validates_uniqueness_of :label, :scope => :post_template_id

  scope :by_type, -> (type) { where(field_type: type) }

  def characteristics
    self.class.const_get("#{FIELD_TYPES[field_type.to_sym]}Field")
  end

  def descriptor_field?
    id == post_template.descriptor_field_id
  end

  def clean_label
    label.parameterize
  end
end
