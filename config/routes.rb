Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  namespace :api, defaults: { format: 'json'} do
    resources :timezones
  end

  root 'application#index'
end
