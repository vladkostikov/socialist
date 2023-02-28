class LikesController < ApplicationController
  include LikesHelper

  before_action :authenticate_user!, only: [:like, :dislike]

  def like
    like = current_user.likes.create_or_find_by(like_params)
    @likeable = like.likeable
    update_button
  end

  def dislike
    like = current_user.likes.find_by(like_params)
    @likeable = like.likeable
    like.destroy
    update_button
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
