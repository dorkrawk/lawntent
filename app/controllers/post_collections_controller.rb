class PostCollectionsController < ApplicationController

  private

  def post_collection_params
    params.require(:post_collection).permit(:title)
  end
end