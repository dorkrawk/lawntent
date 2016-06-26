class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :post_collection
  has_many :post_images, dependent: :destroy

  alias_attribute :author, :user

  validates :post_collection, presence: true
  validates :user, presence: true
  validate :content_must_have_template_fields, unless: Proc.new { |p| p.content.empty? }

  def template
    @template ||= post_collection.template
  end

  def description
    if template.descriptor_field
      content_hash[template.descriptor_field.label]
    else
      created_at.strftime("%b %e %Y %l:%M%P")
    end
  end

  def content_hash
    content.to_h
  end

  def build_json
    additional_fields = {
      post_id: id,
      collection_id: post_collection.id,
      collection_slug: post_collection.slug,
      author: author.try(:email),
      created_at: created_at
    }

    content_hash.merge(additional_fields)
  end

  def has_field?(clean_label)
    template.has_field?(clean_label)
  end

  def image_for_field(template_field)
    return unless has_field?(template_field.clean_label)
    post_images.where(template_field_id: template_field.id).last
  end

  def content_must_have_template_fields
    content_fields = template.template_fields.map { |f| f.clean_label }
    unless content_hash.keys.to_set == content_fields.to_set
      errors.add(:content, "must have all template fields")
    end
  end
end
