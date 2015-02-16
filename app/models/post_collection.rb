class PostCollection < ActiveRecord::Base
  attr_accessor :title

  has_many :posts
  has_many :post_templates

  def template
    post_templates.first
  end
end
