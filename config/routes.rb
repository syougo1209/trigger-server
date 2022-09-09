Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get :health_check, to: 'health_check#index'
  get :test, to: 'test#index'
end
