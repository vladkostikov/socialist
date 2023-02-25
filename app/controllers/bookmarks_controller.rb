class BookmarksController < ApplicationController
  include BookmarksHelper

  before_action :authenticate_user!

  def index
    type = params[:type]
    if type == 'user'
      return @users = current_user.own_bookmarks
                                  .where(bookmarkable_type: 'User')
                                  .order('created_at DESC')
                                  .page(params[:page])
    end

    @articles = current_user.own_bookmarks
                            .where(bookmarkable_type: 'Article')
                            .order('created_at DESC')
                            .page(params[:page])
  end

  def create
    bookmark = current_user.own_bookmarks.create_or_find_by(bookmark_params)
    @bookmarkable = bookmark.bookmarkable
    update_button
  end

  def destroy
    bookmark = current_user.own_bookmarks.find_by(bookmark_params)
    @bookmarkable = bookmark.bookmarkable
    bookmark.destroy
    update_button
  end

  private

  def bookmark_params
    params.permit(:bookmarkable_id, :bookmarkable_type)
  end
end
