class PostTemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @templates = PostTemplate.all
  end

  def show
    @template = PostTemplate.find(params[:id])
  end

  def new
    @template = PostTemplate.new
    @template_field_type_array = TemplateField::FIELD_TYPES.map { |k,v| [v, k] }
  end

  def create
    template = PostTemplate.new(post_template_params)
    if template.save
      flash['notice'] = "Post template created"
      redirect_to template
    else
      flash['alert'] = "Error creating post template: #{post_template.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  private
  def post_template_params
    params.require(:post_template).permit(:title, :descriptor_field_id, :template_fields_attributes => [:post_template_id, :label, :field_type, :_destroy])
  end
end
