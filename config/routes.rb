Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  
  namespace :admin do   
    root to: "homes#top"
    patch 'order_details/:id' => 'order_details#update'
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
  end
  
  
  scope module: :public do
    root to: "homes#top"
    get 'about'=>"homes#about"
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    get 'orders/completed'=>"orders#completed"
    post 'orders/verification'=>"orders#verification"
    resources :orders, only: [:new, :index, :show, :create]
    delete 'cart_items/destroy_all'=>"cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get 'customers/mypage'=>"customers#show"
    get 'customers/information/edit'=>"customers#edit"
    get 'ccustomers/withdrawal/verification'=>"customers#verification"
    patch 'customers/information'=>"customers#update"
    patch 'customers/withdrawal'=>"customers#withdrawal"
    resources :items, only: [:index, :show]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
