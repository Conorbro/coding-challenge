class UserTagsController < ApplicationController

  def new
    @userTag = UserTag.new
  end

  def create
    @userTag = UserTag.new(params.require(:userTag).permit(:tag_id, :user_id))
    if @userTag.save
      redirect_to @userTag
    else
      render 'new'
    end
  end

  def index
    @userTags = UserTag.all
  end

  def show
    @userTag = UserTag.find(params[:id])
  end

end
