class PostsController < ApplicationController

  def show
    @post = post_find(params[:collection_id], params[:post_id])
    respond_to do |format|
      format.html { @post }
      format.json { render json: @post.get_content }
    end
  end

  def new
    get_post_collection
    @post = Post.new(post_collection_id: @post_collection.id,
                     post_template_id: @post_collection.post_template_id,
                     user_id: User.first.id)
  end

  private

  def post_find(collection_id, post_id)
    PostCollection.find(collection_id).posts.find(post_id)
  end

  def get_post_collection
    @post_collection = PostCollection.find(params[:collection_id])
  end

  def post_collection_params
    params.require(:post_collection).permit(:title)
  end
end
