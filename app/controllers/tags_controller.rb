class TagsController < ApplicationController

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params.require(:tag).permit(:name))
    if @tag.save
      redirect_to @tag
    else
      render 'new'
    end
  end

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

end
