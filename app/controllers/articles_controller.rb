class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @article = Article.page(params[:page]).per(15).all.order(created_at: :desc)
    @tags = ActsAsTaggableOn::Tag.most_used(3)
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    url = params[:article][:youtube_url]
    url = url.last(11)
    @article.youtube_url = url
    if @article.save
      redirect_to root_path
    end

  end

  def article_params
    params.require(:article).permit(:title, :text, :tag_list).merge(user_id: current_user.id)
  end
  
end
