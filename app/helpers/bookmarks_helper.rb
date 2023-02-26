module BookmarksHelper
  include ActionView::RecordIdentifier

  def bookmarked?(bookmarkable)
    bookmarkable_params = { bookmarkable_type: bookmarkable.class.to_s,
                            bookmarkable_id: bookmarkable.id }
    current_user&.own_bookmarks&.find_by(bookmarkable_params)
  end

  def update_button
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id(@bookmarkable, :bookmarks),
                               partial: 'bookmarks/button',
                               locals: { bookmarkable: @bookmarkable })
        ]
      end
    end
  end
end
