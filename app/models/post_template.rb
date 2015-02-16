class PostTemplate < ActiveRecord::Base

  has_many :template_fields
  belongs_to :post_collection
end
