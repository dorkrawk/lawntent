class PostCollectionsController < ApplicationController

  before_action :get_post_collection, except: [:create_post]

  def show
    @posts = @post_collection.posts
  end

  def new_post
    @user = User.first # for now
    @template = @post_collection.template
    #@post_fields = @template.template_fields.map { |tf| tf.get_new_field_value }
  end

  def create_post
    post = Post.new(post_collection_id: params[:post][:post_collection_id],
                    post_template_id: params[:post][:post_template_id],
                    user_id: params[:post][:user_id])
    post.transaction do
      post.save!
      params[:field_values].each do |value|
        template_field = TemplateField.find(value.first.to_i)
        field_type = template_field.field_type
        value_field = template_field.value_field.to_sym
        field_value = value.last
        new_field = FieldValue.create(post: post, template_field: template_field, field_type: field_type, value_field => field_value)
      end
    end
    redirect_to post_preview_path(post.post_collection_id, post.id)
  end

  private

  def post_collection_params
    params.require(:post_collection).permit(:title)
  end

  def get_post_collection
    @post_collection = PostCollection.find(params[:id])
  end
end
