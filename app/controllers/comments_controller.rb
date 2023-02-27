class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def edit
    @comment = Comment.find(params[:id])

    if current_user.id != @comment.user_id
      redirect_to @comment, alert: 'Эта публикация принадлежит другому пользователю, ' \
                                   'только он может её редактировать.'
    end
  end

  def create
    commentable = correct_instance(params)
    @comment = commentable.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      new_comment = polymorphic_path(commentable).concat("#comment_#{@comment.id}")
      redirect_to new_comment, notice: 'Комментарий успешно добавлен'
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if current_user.id != @comment.user_id
      return redirect_to @comment, alert: 'Эта публикация принадлежит другому пользователю, ' \
                                          'только он может её редактировать.'
    end

    if @comment.update(comment_update_params)
      redirect_to polymorphic_path(@comment.commentable).concat("#comment_#{@comment.id}")
    else
      render action: 'edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end

  def correct_instance(params)
    klass = Kernel.const_get(params[:comment][:type].to_sym)
    id = params[:comment][:type_id]
    klass.find(id)
  end
end
