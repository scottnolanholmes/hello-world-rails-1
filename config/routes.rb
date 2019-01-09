Rails.application.routes.draw do
  root "hello_worlds#index"

  resources :hello_worlds
end
