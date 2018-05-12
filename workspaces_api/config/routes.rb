Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  api_version(module: 'API/V1', path: { value: '/api/v1' }) do
    resources :users do
      member do
        post 'confirm' => 'users#confirm_email'
      end
    end

    post 'login' => 'sessions#create'
    post 'login_facebook' => 'sessions#login_facebook'

    resources :workspaces do
      collection do
        get 'search/:key' => 'workspaces#search'
      end
    end

    resources :reset_passwords, only: %i[create update]
    resources :convenients, only: :index
    resources :comments, only: %i[index destroy]
    post 'comments/:name' => 'comments#create'
    put 'comments/:name' => 'comments#update'
    resources :orders, only: %i[create update]
    get 'orders/:id' => 'orders#order_of_workspace'
    post 'orders/:id' => 'orders#accept_order'
    post '/orders/clear/:id' => 'orders#clear_order'
  end
end
