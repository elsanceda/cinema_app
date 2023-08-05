Rails.application.routes.draw do
  get 'users/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "dashboard#home"
end
