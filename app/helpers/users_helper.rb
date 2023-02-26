module UsersHelper
  include ActionView::RecordIdentifier

  def following?(user)
    current_user&.followees&.include?(user)
  end

  def update_counters_and_button
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("user_#{@user.id}_follow_button",
                               partial: 'users/follow_button',
                               locals: { user: @user }),
          turbo_stream.update("user_#{@user.id}_friend_count",
                              partial: 'users/friend_count',
                              locals: { user: @user }),
          turbo_stream.update("user_#{@user.id}_subscription_count",
                              partial: 'users/subscription_count',
                              locals: { user: @user }),
          turbo_stream.update("user_#{@user.id}_follower_count",
                              partial: 'users/follower_count',
                              locals: { user: @user })
        ]
      end
    end
  end
end
