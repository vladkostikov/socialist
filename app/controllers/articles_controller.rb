class ArticlesController < ApplicationController
  def new
  end

  def create
    @article = Article.new(article_params)
    if @article.valid?
      @article.save
      redirect_to articles_path
    else
      render action: 'new'
    end
  end

  def index
    @articles = Article.order('id DESC')
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to articles_path
    else
      render action: 'edit'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
