class PostCollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post_collection, except: [:new, :create, :create_post]

  def show
    @posts = @post_collection.posts.order(created_at: :desc)
    respond_to do |format|
      format.html { @posts }
      format.json { render json: @post_collection.description_hash }
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

  def create_post
    Post.transaction do
      content_json = {}
      params[:post][:field_values].each do |value_label, value|
        content_json[value_label.to_sym] = value
      end
      post = Post.new(post_collection_id: params[:post][:post_collection_id],
                      post_template_id: params[:post][:post_template_id],
                      user_id: params[:post][:user_id])

      post_images = params[:post][:images].map do |image_field, image_field_params|
        template_field = post.template.template_fields.where(label: image_field).first
        post_image = PostImage.new(image: image_field_params, template_field_id: template_field.id)
        content_json[image_field.to_sym] = {
          object_type: "image",
          image_url: post_image.image.url
        }
        post_image
      end

      post.content = content_json
      post_save_ok = post.save
      post_save_ok = post_save_ok && post_images.map do |post_image|
        post_image.post = post
        post_image.save
      end.all? { |post_image_saved| post_image_saved == true }

      if post_save_ok
        flash['notice'] = "Post created"
        redirect_to post_path(post.post_collection_id, post.id)
      else
        flash['alert'] = "Error creating post: #{post.errors.full_messages.to_sentence}"
        redirect_to :back
      end
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
