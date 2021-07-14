Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  post '/login', to: 'sessions#create'
  get '/dashboard', to: 'dashboards#index'
  post '/add_friend', to: 'dashboards#add_friend' #holy unrestful
  get '/discover', to: 'movies#new_search'
  get '/movies', to: 'movies#search'
  delete '/logout', to: 'sessions#destroy'
  get '/movies/:id', to: 'movies#show'

  resources :parties, only: [:new, :create]
end
