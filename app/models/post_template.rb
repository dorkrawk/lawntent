class PostTemplate < ActiveRecord::Base

  has_many :template_fields, dependent: :destroy
  has_many :post_collections

  accepts_nested_attributes_for :template_fields, reject_if: :all_blank, allow_destroy: true

  def descriptor_field
    @descriptor_field ||= template_fields.find_by(id: descriptor_field_id) ||
                          template_fields.by_type(:text).first
  end

  def used?
    post_collections.any?
  end
end
