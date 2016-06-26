class PagesController < ApplicationController

  def index
    @post_collections = PostCollection.by_owner(current_user).sort { |x, y| x.posts.any? && y.posts.any? ? y.posts.last.created_at <=> x.posts.last.created_at : x.posts.any? ? -1 : 1 }
  end

  def login
  end

end
