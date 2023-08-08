Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'dashboard#home'
  get  '/signup',  to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get  '/admin',  to: 'dashboard#admin'
  resources :users, only: [:new, :create]
  resources :movies
  resources :cinemas do
    member do
      get :bookings
    end
  end
  resources :showings do
    collection do
      get :free_timeslots
    end
    member do
      get :bookings
    end
  end
end
