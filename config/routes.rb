Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")

  get 'pages/home'
  root 'public_recipes#index'
  get 'general_shopping_list/index'
  resources :recipe_foods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :recipes
  resources :foods, only: [:index, :show, :new, :create, :destroy]
  get 'shopping_list' => 'foods#shopping_list'
end
