Rails.application.routes.draw do
  resources :books do
    member {get 'confirm_delete'}
  end
  root 'books#index'
end