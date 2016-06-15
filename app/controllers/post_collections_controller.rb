class PostCollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post_collection, except: [:new, :create, :create_post]

  def show
    @posts = @post_collection.posts.order(created_at: :desc)
    respond_to do |format|
      format.html { @posts }
      format.json { render json: @post_collection.build_json }
    end
  end

  def posts
    limit = params[:limit].to_i
    respond_to do |format|
      format.json { render json: @post_collection.build_posts_json(limit) }
    end
  end

  def new
    @post_templates_arrary = PostTemplate.all.map { |template| [template.title, template.id] }
    @post_collection = PostCollection.new
  end

  def create
    post_collection = PostCollection.new(post_collection_params)

    if post_collection.save
      flash['notice'] = "Post Collection created"
      redirect_to post_collection
    else
      flash['alert'] = "Error creating post collection: #{post_collection.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  private

  def post_collection_params
    params.require(:post_collection).permit(:title, :post_template_id)
  end

  def get_post_collection
    @post_collection = PostCollection.find(params[:id])
  end
end
