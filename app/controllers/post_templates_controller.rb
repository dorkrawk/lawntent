class PostTemplatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @templates = PostTemplate.all
  end

  def show
    @template = PostTemplate.find(params[:id])
  end
end
