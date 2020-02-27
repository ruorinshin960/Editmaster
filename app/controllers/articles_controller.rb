class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    Article.create(article_params)
    redirect_to root_path
  end

  def article_params
    params.require(:article).permit(:title, :text, :tag_list).merge(user_id: current_user.id)
  end
  
end
