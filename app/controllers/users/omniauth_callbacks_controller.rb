# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  #def twitter
  # callback_for(:twitter)
  #end

  def google_oauth2
    callback_for(:google)
  end

 def callback_for(provider)
    provider = provider.to_s
    @user = User.find_oauth(request.env["omniauth.auth"])
  
    session[:uid] = @user.uid
    session[:provider] = @user.provider
    session[:nickname] = @user.nickname
    session[:email] = @user.email
    session[:password] = @user.password

    if @user.persisted?       #userが存在したら。
      sign_in_and_redirect @user, event: :authentication  #after_sign_in_path_forと同じ。（ログイン時実行されるメソッド、ログイン時に飛んでほしいページを指定）
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else  
      @user = User.create(
        nickname: session[:nickname],
        email: session[:email],
        password: session[:password],
        uid: session[:uid],
        provider: session[:provider]
      )
      sign_in(@user)
      redirect_to root_path , notice: 'サインアップしました'
    end
  end

  def failure
    redirect_to root_path 
  end
end
