class ArticlesController < ApplicationController
  def new
  end

  def create
    @article = Article.new(article_params)
    if @article.valid?
      @article.save
    else
      render action: 'new'
    end
  end

  def index
    @articles = Article.order('id DESC')
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
