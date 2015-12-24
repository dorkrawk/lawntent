class PostTemplate < ActiveRecord::Base

  has_many :template_fields, dependent: :destroy
  has_many :post_collections

  def descriptor_field
    @descriptor_field ||= template_fields.find_by(id: descriptor_field_id) || template_fields.first
  end

  def used?
    post_collections.any?
  end
end
