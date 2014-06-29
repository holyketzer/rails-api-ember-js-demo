Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json'} do
    resources :time_zones
  end

  root 'application#index'
end
