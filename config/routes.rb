Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/, defaults: {locale: :en} do
    root "my_anime_list#show", page: "home"
    get "my_anime_list/:page", to: "my_anime_list#show"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users, only: [:show,:index]
    resources :account_activations, only: :edit
    resources :animes, only: [:show,:index]
  end
end
