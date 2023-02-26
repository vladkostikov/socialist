class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    section = params[:section]
    if user_signed_in? && section
      friends = current_user.followee_ids & current_user.follower_ids
      peoples = case section
                when 'friends'
                  friends
                when 'subscriptions'
                  current_user.followee_ids - friends
                when 'followers'
                  current_user.follower_ids - friends
                end

      return @articles = Article.where(user_id: peoples)
                                .order('id DESC')
                                .page(params[:page])
    end

    @articles = Article.order('id DESC').page(params[:page])
  end

  def show
    @article = Article.find(params[:id])
    @comments = Comment.comments_find(Article, @article.id)
    @replies = Comment.replies_find(Article, @article.id)
  end

  def new; end

  def edit
    @article = Article.find(params[:id])

    if current_user.id != @article.user_id
      redirect_to @article, alert: 'Эта публикация принадлежит другому пользователю, ' \
                                   'только он может её редактировать.'
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    redirect_back(fallback_location: articles_path) if @article.save
  end

  def update
    @article = Article.find(params[:id])

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
