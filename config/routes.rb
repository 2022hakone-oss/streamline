Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :blogs

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   patch 'tweets/:id' => 'tweets#update'
  get 'tweets/:id/edit' => 'tweets#edit', as:'edit_tweet'
end


