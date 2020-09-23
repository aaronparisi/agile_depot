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
  
  resources :users do
    collection do
      get 'forgot_password', to: "users#forgot_password", as: "forgot_password"
      post 'send_password_reset_email', to: "users#send_password_reset_email"
      get 'check_email', to: "users#check_email"
    end
    member do
      get 'recover_password', to: 'users#recover_password'
      post 'update_password', to: 'users#update_password'
      get 'update_info', to: 'users#password_confirmation'
      post 'update_info', to: 'users#confirm_password'
    end
  end
  
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
