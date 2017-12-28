Rails.application.routes.draw do
  resources :categories
  resources :buildings
  resources :events
  resources :games
  resources :groups do
    resources :constructed_buildings do
      resources :event_logs
    end
  end

  get '/add_event_log', to: 'event_logs#add'


  devise_for :users
  root to: 'groups#index'

end
