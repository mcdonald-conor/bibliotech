Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :books, only: [:index, :create] do
    collection do
      post 'save', to: 'books#save'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get 'home', to: 'pages#home'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'library', to: 'pages#library'
  get 'search_books', to: 'books#search'
end
