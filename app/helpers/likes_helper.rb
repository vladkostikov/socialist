module LikesHelper
  include ActionView::RecordIdentifier

  def liked?(likeable)
    likeable_params = { likeable_type: likeable.class.to_s,
                        likeable_id: likeable.id }
    current_user&.likes&.find_by(likeable_params)
  end

  def update_button
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id(@likeable, :likes),
                               partial: 'likes/button',
                               locals: { likeable: @likeable })
        ]
      end
    end
  end
end
