Rails.application.routes.draw do
  # resources :sessions do
  #   only: [:new, :create, :destroy]
  # end
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :admin, only: :index
  resources :users
  resources :orders do
    get :ship, on: :member
  end
  resources :line_items
  resources :carts #do
  #   delete :empty, on: :member
  # end
  # get 'store/index' replaced by root
  resources :products do
    get :who_bought, on: :member
  end

  root 'store#index', as: 'store_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
