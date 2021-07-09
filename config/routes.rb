Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  post '/login', to: 'sessions#create'
  get '/dashboard', to: 'dashboards#index'
  delete '/logout', to: 'sessions#destroy'

end
