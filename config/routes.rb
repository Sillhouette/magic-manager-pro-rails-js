Rails.application.routes.draw do
  resources :users
  resources :deck_cards
  resources :magic_cards
  resources :decks
  resources :user_cards

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
