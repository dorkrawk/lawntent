class Post < ActiveRecord::Base

  has_one :post_template
  belongs_to :user
  belongs_to :post_collection
end
