class PostTemplatesController < ApplicationController

  def index
    @templates = PostTemplate.all
  end

  def show
    @template = PostTemplate.find(params[:id])
  end
end
