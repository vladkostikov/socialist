class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.order('id DESC')
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.order('id DESC')
  end

  def new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article
    else
      render action: 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])

    # Проверка что пользователь автор публикации
    if current_user.id != @article.user_id
      return render plain: 'Эта публикация принадлежит другому пользователю, ' \
                           'только он может её редактировать.'
    end
  end

  def update
    @article = Article.find(params[:id])

    # Проверка что пользователь автор публикации
    if current_user.id != @article.user_id
      return render plain: 'Эта публикация принадлежит другому пользователю, ' \
                           'только он может её редактировать.'
    end

    if @article.update(article_params)
      redirect_to articles_path
    else
      render action: 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])

    # Проверка что пользователь автор публикации
    if current_user.id != article.user_id
      return render plain: 'Эта публикация принадлежит другому пользователю, ' \
                           'только он может её редактировать.'
    end

    article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
