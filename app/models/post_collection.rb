class PostCollection < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :scoped], scope: :owner_id

  has_many :posts
  belongs_to :post_template
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  validates :owner, presence: true

  alias_attribute :name, :title

  def template
    post_template
  end

  def build_json
    {
      title: title,
      slug: slug,
      owner: owner.email,
      template: post_template_id,
      post_count: posts.count
    }
  end

  def build_posts_json(limit = 10)
    posts.order(created_at: :desc).limit(limit).map { |post| post.build_json }
  end
end
