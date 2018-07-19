Rails.application.routes.draw do
  resources :magic_cards
  resources :users
  resources :decks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
