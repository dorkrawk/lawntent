class Post < ActiveRecord::Base
  attr_accessor :post_collection, :post_collection_id, :user_id, :user,
                  :post_template, :post_template_id

  has_many :field_values
  has_one :post_template
  belongs_to :user
end
