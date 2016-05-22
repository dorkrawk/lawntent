class PostCollection < ActiveRecord::Base

  has_many :posts
  belongs_to :post_template

  alias_attribute :name, :title

  def template
    post_template
  end

  def description_hash
    {
      title: title,
      template: post_template_id,
      post_count: posts.count
    }
  end
end
