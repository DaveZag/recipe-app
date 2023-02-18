Rails.application.routes.draw do
  devise_for :users

  get 'pages/home'
  root 'public_recipes#index'
  get 'general_shopping_list/index'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :recipes do 
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :foods, only: [:index, :show, :new, :create, :destroy]
  get 'shopping_list' => 'foods#shopping_list'
  resources :inventory do
    resources :inventory_foods, only: [:new, :create, :destroy, :index]
  end

end
