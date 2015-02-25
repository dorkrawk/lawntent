class PostsController < ApplicationController

  def index

  end

  def show
    @post = post_find(params[:collection_id], params[:post_id]) #Post.find(params[:id]) #
    render json: @post.get_content
  end

  def preview
    @post = post_find(params[:collection_id], params[:post_id])
  end

  private

  def post_find(collection_id, post_id)
      PostCollection.find(collection_id).posts.find(post_id)
    end

  def post_collection_params
    params.require(:post_collection).permit(:title)
  end
end