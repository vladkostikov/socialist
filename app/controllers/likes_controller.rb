class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    like = current_user.likes.find_by(like_params)

    if like.nil?
      new_like = current_user.likes.create(like_params)
      likeable = new_like.likeable
      redirect_to likeable
    else
      likeable = like.likeable
      like.destroy
      redirect_to likeable
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
