class Post < ActiveRecord::Base

  has_many :field_values
  has_one :post_template
  belongs_to :user
end
