Rails.application.routes.draw do
  resources :users do
    resources :user_cards, only: [:index] #:new, #removed new as it is now handled on the index page via JS
    resources :decks
  end

  resources :magic_cards, only: [:show, :index]

  resources :user_cards, only: [:new, :index, :edit, :create, :destroy, :update]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  post '/generate_cards' => 'magic_cards#generate_cards'
  delete '/logout' => 'sessions#destroy'

  root 'welcome#index'
end
