Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/, defaults: {locale: :en} do
    root "my_anime_list#show", page: "home"
    get "my_anime_list/:page", to: "my_anime_list#show"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: :show
  end
end
