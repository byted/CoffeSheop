CoffeeShop::Application.routes.draw do
  


  resources :histories


  match 'login' => 'user_sessions#new', as: :login
  match 'logout' => 'user_sessions#destroy', as: :logout
  match 'admin' => 'admin#index', as: :admin
  match 'admin/settings' => 'admin#settings', as: :admin_settings
  match 'admin/update_settings' => 'admin#update_settings', as: :admin_update_settings, via: :post
  match 'store' => 'store#index', as: :store
  match 'add_money' => 'users#add_money', as: :add_money
  match 'replenish' => 'products#replenish', as: :replenish
  match 'users/update_balance' => 'users#update_balance', as: :update_balance
  match 'users/edit_me' => 'users#edit_me', as: :edit_me
  match 'products/replenish' => 'products#update_stock', as: :update_stock
  match 'cleanings/howto' => 'cleanings#howto', as: :cleaning_howto
  match 'ask_pin' => 'user_sessions#ask_pin', as: :ask_pin
  match 'verify' => 'user_sessions#verify', as: :verify
  match 'checkout' => 'carts#checkout', as: :checkout
  match 'invoice' => 'carts#invoice', as: :invoice

  resources :cleanings


  resources :orders


  resources :usergroups
  

  resources :users


  resources :items_in_carts


  resources :carts 


  get "store/index"

  resources :products

  resources :user_sessions

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  #root to: 'store#index', as: 'store'
  root to: 'user_sessions#new', as: 'root'
  # See how all your routes lay out with "rake routes"
end