class PostTemplate < ActiveRecord::Base

  has_many :template_fields, dependent: :destroy
  belongs_to :post_collection

  def descriptor_field
    @descriptor_field ||= template_fields.find(descriptor_field_id)
  end
end
