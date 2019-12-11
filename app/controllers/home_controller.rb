class HomeController < Front::ApplicationController

  def index
    @articles = Article.order('id DESC').limit(3)
  end
end
