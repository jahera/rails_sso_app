Rails.application.routes.draw do
  # devise_for :users
  root to: "home#index"
  devise_for :user, controllers: {
    registrations: "registrations",
    sessions: "sessions"
  }

  devise_scope :user do
    get '/sign_out' => 'sessions#destroy'
  end
  # devise_for :users, controllers: { saml_sessions: 'users/saml_sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
