class PostTemplate < ActiveRecord::Base
  attr_accessor :title, :post_collection, :post_collection_id

  has_many :template_fields
  belongs_to :post_collection
end
