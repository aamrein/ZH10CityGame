Rails.application.routes.draw do
  resources :tasks
  resources :categories
  resources :buildings
  resources :events
  resources :games
  resources :groups do
    resources :task_logs
    resources :constructed_buildings do
      resources :event_logs
    end
  end

  get '/add_event_log', to: 'event_logs#add'
  get '/add_task_log', to: 'task_logs#add'

  devise_for :users
  root to: 'groups#index'

end
