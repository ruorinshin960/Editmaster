class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :tag_rank

  def index
    @article = Article.page(params[:page]).per(15).all.order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def search
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :root
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find_by(id: params[:id])
    if @article.update_attributes(article_edi_params)
      redirect_to root_path
    else
      render action: :edit
    end
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

  private

  def article_params
    params.require(:article).permit(:title, :text, :tag_list).merge(user_id: current_user.id)
  end

  def tag_rank
    @tags = ActsAsTaggableOn::Tag.most_used(3)
  end

  def article_edi_params
    params.require(:article).permit(:title, :text, :tag_list)
  end

end
