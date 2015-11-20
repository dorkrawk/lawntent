class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :post_collection

  alias_attribute :author, :user

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
end
