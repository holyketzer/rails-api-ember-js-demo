Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json'} do
    resources :timezones
  end

  root 'application#index'
end
