class UsersController < ApplicationController

   def show
      @post = Article.find_by(id:params[:id])
      @user = User.find_by(id: @post.user_id)
      @articles = @user.articles.page(params[:page]).per(7).all.order(created_at: :desc)
      @article = current_user.articles.page(params[:page]).per(7).all.order(created_at: :desc)
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
