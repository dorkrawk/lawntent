class PagesController < ApplicationController

  def index
    @post_collections = PostCollection.all.sort { |x, y| x.posts.last.created_at <=> y.posts.last.created_at }
  end

  def login
  end

end
