class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable,omniauth_providers: %i[google_oauth2]

  has_many :articles, dependent: :destroy
  acts_as_ordered_taggable_on :skills, :interests
  
  mount_uploader :image, ImageUploader

  def self.find_oauth(auth)
    @user = User.where(uid: auth.uid, provider: auth.provider).first #userテーブルにprovider、uidがあったらログイン処理
              
      unless @user       
        @user = User.new(
                        uid: auth.uid,
                        provider: auth.provider,
                        nickname: auth.info.name,
                        email: auth.info.email,
                        password: Devise.friendly_token[0, 20],
                      )
      end
     return @user
    end

end
