class PostsController < ApplicationController
  include PostBuilder

  before_action :authenticate_user!

  def show
    @post = post_find(params[:collection_id], params[:post_id])
    respond_to do |format|
      format.html { @post }
      format.json { render json: @post.build_json }
    end
  end

  def new
    get_post_collection
    @post = Post.new(post_collection_id: @post_collection.id,
                     post_template_id: @post_collection.post_template_id,
                     user_id: current_user.id)
    @post_values = {}
  end

  def create
    Post.transaction do
      post = Post.new(post_collection_id: params[:post][:post_collection_id],
                      post_template_id: params[:post][:post_template_id],
                      user_id: params[:post][:user_id])

      content_json = build_basic_content_json(params)
      content_json = handle_boolean_fields(params, content_json, post.template)
      content_json, post_images = handle_image_fields(params, content_json, post.template)

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

  def edit
    get_post_collection
    @post = post_find(params[:collection_id], params[:post_id])
    @post_values = {}
    @post.template.template_fields.each do |template_field|
      @post_values[template_field.clean_label] = @post.content_hash[template_field.clean_label]
    end
  end

  def update
    Post.transaction do
      post = post_find(params[:collection_id], params[:post_id])
      content_json = build_basic_content_json(params, post.content_hash)
      content_json = handle_boolean_fields(params, content_json, post.template)
      content_json, post_images = handle_image_fields(params, content_json, post.template)
      post_save_ok = post.update_attributes(content: content_json)
      post_save_ok = post_save_ok && post_images.map do |post_image|
        post_image.post = post
        post_image.save
      end.all? { |post_image_saved| post_image_saved == true }

      if post_save_ok
        flash['notice'] = "Post updated"
        redirect_to post_path(post.post_collection_id, post.id)
      else
        flash['alert'] = "Error updating post: #{post.errors.full_messages.to_sentence}"
        redirect_to :back
      end
    end
  end

  private

  def post_find(collection_id, post_id)
    PostCollection.find(collection_id).posts.find(post_id)
  end

  def get_post_collection
    @post_collection = PostCollection.find(params[:collection_id])
  end

end
