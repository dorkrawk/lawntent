class PostCollection < ActiveRecord::Base

  has_many :posts
  has_many :post_templates

  alias_attribute :name, :title

  def template
    post_templates.first
  end
end
