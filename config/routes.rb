Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :books, only: [:index, :create, :destroy] do
    collection do
      post 'save'
    end
    member do
      post 'update_category'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get 'home', to: 'pages#home'
  get 'how_it_works', to: 'pages#how_it_works'
  get 'library', to: 'books#index', as: 'library'
  get 'search_books', to: 'books#search'

end
