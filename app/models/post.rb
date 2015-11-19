class Post < ActiveRecord::Base

  has_one :post_template
  belongs_to :user
  belongs_to :post_collection

  alias_attribute :author, :user

  def get_content
    additional_fields = {
      post_id: id,
      collection_id: post_collection.id,
      author: author.try(:email),
      created_at: created_at
    }

    content.to_h.merge(additional_fields)
  end
end
