Rails.application.routes.draw do
  resources :users
  post 'auth/login', to: 'authentication#login', as: :authenticate
  get 'check/list', to: 'authentication#checking_list'
end
