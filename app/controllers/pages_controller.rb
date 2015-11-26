class PagesController < ApplicationController

  def index
    @post_collections = PostCollection.all
  end

end
