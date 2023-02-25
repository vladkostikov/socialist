class UsersController < ApplicationController
  include UsersHelper

  before_action :authenticate_user!, only: [:friends, :follow, :unfollow]

  def index
    @q = User.ransack(params[:q])
    @result = @q.result
    @users = @result.order('id ASC').page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.wall.articles.where.not(id: nil).order('id desc').page(params[:page])
  end

  def username
    @user = User.find_by(username: params[:username])
    @articles = @user.wall.articles.where.not(id: nil).order('id desc').page(params[:page])
    render 'show'
  end

  def friends
    @user = User.find(params[:user_id])
    @friends = @user.followees & @user.followers
    @count = @friends.size
    @users = Kaminari.paginate_array(@friends).page(params[:page])
    render 'users/relationships', locals: { name: 'Друзья' }
  end

  def followers
    @user = User.find(params[:user_id])
    @friends = @user.followees & @user.followers
    @followers = @user.followers - @friends
    @count = @followers.size
    @users = Kaminari.paginate_array(@followers).page(params[:page])
    render 'users/relationships', locals: { name: 'Подписчики' }
  end

  def subscriptions
    @user = User.find(params[:user_id])
    @friends = @user.followees & @user.followers
    @subscriptions = @user.followees - @friends
    @count = @subscriptions.size
    @users = Kaminari.paginate_array(@subscriptions).page(params[:page])
    render 'users/relationships', locals: { name: 'Подписки' }
  end

  def follow
    @user = User.find(params[:id])
    Relationship.create_or_find_by(follower_id: current_user.id,
                                   followee_id: @user.id)
    update_counters_and_button
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.where(follower_id: current_user.id,
                                      followee_id: @user.id).destroy_all
    update_counters_and_button
  end
end
