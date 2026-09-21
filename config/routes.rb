Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get "/boards", to: "boards#index", as: :boards
  get "/how-to-play", to: "how_to_play#show", as: :how_to_play
  get "/rounds", to: "rounds#index", as: :rounds
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/.well-known/appspecific/com.chrome.devtools.json", to: proc { [404, {}, [""]] }
  get "/favicon.ico", to: proc { [204, {}, [""]] }

  namespace :admin do
    root to: "dashboard#index"
    get "/synonyms", to: "synonyms#catalog", as: :synonyms
    resources :boards, only: [:index, :show, :edit, :update] do
      resources :synonyms, only: [:index, :new, :create, :edit, :update, :destroy]
    end
    resources :users, only: [:index, :edit, :update]
    resources :transactions, only: [:index, :show]
  end
end
