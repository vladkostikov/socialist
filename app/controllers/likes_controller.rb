class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    like = current_user.likes.new(like_params)

    if like.save
      redirect_to like.likeable
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy
    redirect_to like.likeable
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
