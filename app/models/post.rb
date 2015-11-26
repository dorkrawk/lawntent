class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :post_collection

  alias_attribute :author, :user

  validates :post_collection, presence: true
  validates :user, presence: true
  validate :content_must_have_template_fields, unless: Proc.new { |p| p.content.empty? }

  def template
    @template ||= post_collection.template
  end

  def description
    content_hash[template.descriptor_field.label]
  end

  def content_hash
    content.to_h
  end

  def get_content
    additional_fields = {
      post_id: id,
      collection_id: post_collection.id,
      author: author.try(:email),
      created_at: created_at
    }

    content_hash.merge(additional_fields)
  end

  def content_must_have_template_fields
    content_fields = template.template_fields.map { |f| f.label }
    unless content_hash.keys == content_fields
      errors.add(:content, "must have template fields")
    end
  end

  def content_valid?
    content_fields = template.template_fields.map { |f| f.label }
    content_hash.keys == content_fields
  end
end
