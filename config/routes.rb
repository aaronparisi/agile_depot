Rails.application.routes.draw do
  # get 'store/index' replaced by root
  resources :products

  root 'store#index', as: 'store_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
