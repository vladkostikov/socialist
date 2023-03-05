class LikesController < ApplicationController
  include LikesHelper

  before_action :authenticate_user!, only: [:like, :dislike]

  def like
    like = current_user.likes.create_or_find_by(like_params)
    @likeable = like.likeable
    update_button
  end

  def dislike
    if (like = current_user.likes.find_by(like_params))
      like.destroy
    end
    @likeable = likeable(like_params)
    update_button
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

  def likeable(params)
    klass = Kernel.const_get(params[:likeable_type].to_sym)
    id = params[:likeable_id]
    klass.find(id)
  end
end
