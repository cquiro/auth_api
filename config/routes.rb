Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update, :destroy]

  post 'verify_user/:email', to: 'user_verifications#create', constraints: { email: /[^\/]+/ }
end
