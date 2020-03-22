Rails.application.routes.draw do
  devise_for :users, controllers: {  sessions: 'users/sessions' ,
                                     registrations: 'users/registrations' ,
                                     omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'

  resources :articles do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end

  resources :users, only: [:show,:edit,:update]

end

