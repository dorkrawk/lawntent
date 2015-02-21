class PostCollectionsController < ApplicationController

  def new_post
    @post_collection = PostCollection.find(params[:id])
    @template = @post_collection.template
    @post_fields = @template.template_fields.map { |tf| tf.get_new_field_value }
  end

  private

  def post_collection_params
    params.require(:post_collection).permit(:title)
  end
end