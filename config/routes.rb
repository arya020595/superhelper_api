Rails.application.routes.draw do
  
  namespace :api do
    resources :users do
      post :login, on: :collection
    end
  end

  # resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
