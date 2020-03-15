class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configre_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
    @search = Article.ransack(params[:q]) #ransackの検索メソッド
    @search_articles = @search.result(distinct: true).order(created_at: "DESC").includes(:user).page(params[:page]).per(15)
     # 検索結果の一覧：  @search_articles = @search.result.order(created_at: "DESC")
     # distinct: trueは検索結果のレコード重複しないようにします。
  end
  
  def after_sign_in_path_for(resource)
    root_path(resource.id)
  end

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:email,:password])
  end

  def after_sign_out_path_for(resource)
    root_path # サインアウト後のリダイレクト先URL
  end
end
