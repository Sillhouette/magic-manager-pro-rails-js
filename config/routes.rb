Rails.application.routes.draw do
  resources :users, only: [:new, :show, :edit] do
    resources :user_cards, only: [:new, :index]
  end
  #resources :deck_cards, only: [:new, :index]
  resources :magic_cards, only: [:show]
  resources :decks
  resources :user_cards, only: [:new, :index, :edit, :create, :destroy, :update]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
