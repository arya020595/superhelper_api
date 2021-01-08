Rails.application.routes.draw do
  
  namespace :api do
    resources :users do
      post :login, on: :collection
    end

    resources :locations, only: [:index, :show] do
      get "search/:keyword", :to => "locations#search", :on => :collection
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
