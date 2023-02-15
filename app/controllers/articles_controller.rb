class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.order('id DESC')
  end

  def show
    @article = Article.find(params[:id])
    @comments = Comment.comments_find(Article, @article.id)
    @replies = Comment.replies_find(Article, @article.id)
  end

  def new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_back(fallback_location: articles_path)
    end
  end

  def edit
    @article = Article.find(params[:id])

    # Проверка что пользователь автор публикации
    if current_user.id != @article.user_id
      redirect_to @article, alert: 'Эта публикация принадлежит другому пользователю, ' \
                                 'только он может её редактировать.'
    end
  end

  def update
    @article = Article.find(params[:id])

    # Проверка что пользователь автор публикации
    if current_user.id != @article.user_id
      return redirect_to @article, alert: 'Эта публикация принадлежит другому пользователю, ' \
                           'только он может её редактировать.'
    end

    if @article.update(article_params)
      redirect_to @article
    else
      render action: 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])

    # Проверка что пользователь автор публикации
    if current_user.id != article.user_id
      return redirect_to article, alert: 'Эта публикация принадлежит другому пользователю, ' \
                           'только он может её удалить.'
    end

    article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:text, :wall_id)
  end
end
