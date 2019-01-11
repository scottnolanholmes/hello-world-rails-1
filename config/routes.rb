Rails.application.routes.draw do
  root "hello_worlds#hello"

  resources :hello_worlds
end
