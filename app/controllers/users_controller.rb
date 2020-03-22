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
       redirect_to root_path
     else
       render :edit
     end
   end

   private

   def user_params
     params.require(:user).permit(:image, :nickname, :email)
   end

end
