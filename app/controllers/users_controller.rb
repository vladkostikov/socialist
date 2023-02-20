class UsersController < ApplicationController
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
end
