class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    section = params[:section]
    likes_type = params[:likes]

    if user_signed_in? && section
      @articles = find_articles(section)
      return render 'feed/articles'
    elsif user_signed_in? && likes_type
      @likes_comments = find_likes(likes_type) if likes_type == 'comments'
      @likes_articles = find_likes(likes_type) unless @likes_comments
      return render 'feed/likes'
    end

    @articles = Article.order('created_at DESC').page(params[:page])
    render 'feed/articles'
  end

  def show
    @article = Article.with_all_rich_text.find(params[:id])
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
    params.require(:article).permit(:wall_id, :content)
  end

  def find_peoples_ids(section)
    friends = current_user.followee_ids & current_user.follower_ids
    case section
    when 'subscriptions'
      current_user.followee_ids - friends
    when 'followers'
      current_user.follower_ids - friends
    else
      friends
    end
  end

  def find_articles(section)
    peoples = find_peoples_ids(section)
    Article.where(user_id: peoples)
           .order('created_at DESC')
           .page(params[:page])
  end

  def find_likes(likes_type)
    case likes_type
    when 'comments'
      current_user.likes.where(likeable_type: 'Comment')
                  .order('created_at DESC')
                  .page(params[:page])
    else
      current_user.likes.where(likeable_type: 'Article')
                  .order('created_at DESC')
                  .page(params[:page])
    end
  end
end
