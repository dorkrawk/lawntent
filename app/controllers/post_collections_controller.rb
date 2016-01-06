class PostCollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post_collection, except: [:create_post]

  def show
    @posts = @post_collection.posts
  end

  def new_post
    @user = current_user
    @template = @post_collection.template
  end

  def create_post
    # clean this up to a .map?
    content_json = {}
    params[:post][:field_values].each do |value_label, value|
      content_json[value_label.to_sym] = value
    end
    post = Post.new(post_collection_id: params[:post][:post_collection_id],
                    post_template_id: params[:post][:post_template_id],
                    user_id: params[:post][:user_id],
                    content: content_json)

    if post.save
      flash['notice'] = "Post created"
      redirect_to post_path(post.post_collection_id, post.id)
    else
      flash['error'] = "Error creating post: #{post.errors.full_messages.to_sentence}"
    end
  end

  private

  def post_collection_params
    params.require(:post_collection).permit(:title)
  end

  def get_post_collection
    @post_collection = PostCollection.find(params[:id])
  end
end
