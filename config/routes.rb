Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/, defaults: {locale: :en} do
    root "my_anime_list#show", page: "home"
    get "my_anime_list/:page", to: "my_anime_list#show"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :genres, only: [:show, :index]
    post "/rate", to: "rater#create", as: "rate"
    resources :users, only: [:show, :index] do
      resources :relationships, only: :index
    end
    resources :account_activations, only: :edit
    resources :animes, only: [:show, :index] do
      resources :reviews, except: [:index]
    end
    namespace :admin do
      resources :animes, only: [:new, :create]
    end
    resources :reviews, only: :index
    resources :relationships, only: [:create, :destroy ]
  end
end
