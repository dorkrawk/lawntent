class PostCollection < ActiveRecord::Base

  has_many :posts
  belongs_to :post_template

  alias_attribute :name, :title

  def template
    post_template
  end

  def build_json
    {
      title: title,
      template: post_template_id,
      post_count: posts.count
    }
  end

  def build_posts_json(limit = 10)
    posts.order(created_at: :desc).limit(limit).map { |post| post.build_json }
  end
end
