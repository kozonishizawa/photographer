class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_articles_path, flash: { success: "記事#{@article.title}を投稿しました"}
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.update!(params[:id])
    redirect_to admin_articles_path, flash: { success: "記事#{@article.title}を更新しました"}
  end

  def destroy
    @article = Article.find(params[:id])
    @article.delete
    redirect_to admin_articles_path, flash: { success: "記事を削除しました"}
  end

  private
    def article_params
      params.require(:article).permit :title, :body, :status
    end
end
