class PostCollection < ActiveRecord::Base

  has_many :posts
  has_many :post_templates

  def template
    post_templates.first
  end
end
