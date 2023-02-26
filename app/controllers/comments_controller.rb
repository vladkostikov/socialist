class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    commentable = correct_instance(params)
    @comment = commentable.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      new_comment = polymorphic_path(commentable).concat("#comment_#{@comment.id}")
      redirect_to new_comment, notice: 'Комментарий успешно добавлен'
    end
  end

  def correct_instance(params)
    klass = Kernel.const_get(params[:comment][:type].to_sym)
    id = params[:comment][:type_id]
    klass.find(id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
