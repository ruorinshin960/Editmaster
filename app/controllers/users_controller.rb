class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

   def show
      @user = User.find_by(id:params[:id])
      @articles = @user.articles.page(params[:page]).per(3).all.order(created_at: :desc)
   end

   def edit
   end
 
   def update
    if current_user.update(user_params)
      flash[:success] = 'ユーザー情報を編集しました。'
      redirect_to "/users/#{current_user.id}"
    else
      flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
      render :edit
    end   
   end

   private

   def user_params
     params.require(:user).permit(:image, :nickname, :email)
   end

end
