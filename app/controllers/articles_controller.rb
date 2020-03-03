class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @article = Article.page(params[:page]).per(15).all.order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    Article.create(article_params)
    redirect_to root_path
  end

  def article_params
    params.require(:article).permit(:title, :text, :tag_list).merge(user_id: current_user.id)
  end
  
end
