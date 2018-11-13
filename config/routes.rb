Rails.application.routes.draw do
  resources :users, except: [:edit] do
    resources :user_cards, only: [:new, :index]
    resources :decks
  end

  resources :magic_cards, only: [:show]

  resources :user_cards, only: [:new, :index, :edit, :create, :destroy, :update]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  root 'welcome#index'
end
