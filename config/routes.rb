Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/.well-known/appspecific/com.chrome.devtools.json", to: proc { [404, {}, [""]] }
  get "/favicon.ico", to: proc { [204, {}, [""]] }

  namespace :admin do
    root to: "dashboard#index"
    resources :boards, only: [:index, :show, :edit, :update]
    resources :users, only: [:index, :edit, :update]
    resources :transactions, only: [:index, :show]
  end
end
