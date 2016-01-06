class PagesController < ApplicationController

  def index
    @post_collections = PostCollection.all
  end

  def login
  end

end
