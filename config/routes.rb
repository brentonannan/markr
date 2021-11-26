Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :imports, only: :create
  get '/results/:test_id/aggregate', to: 'test/statistics#show', as: :test_statistics
end
