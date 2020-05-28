Rails.application.routes.draw do
  resources :comments
  resources :analytics, only: [:index]
  resources :habits do
    patch 'complete_habit', on: :member
  end
  resources :categories
  resources :goals do
    patch 'cheer', on: :member
    patch 'complete_goal', on: :member
    # post  'edit', to: "goals#show", on: :member
  end

  resources :users, only: [:show, :index, :edit, :update, :destroy] do
    get 'journal', on: :member
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"

  get '/signup', to: "users#new"
  post '/signup', to: "users#create"

  post '/goals/:id/edit', to: "goals#show"

  delete '/logout', to: "sessions#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
