SmartReserve::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  #get "users/profile"
  post 'change_locale/:locale', to: 'application#change_locale', as: :change_locale
  post 'set_locale', to: 'application#set_locale', as: :set_locale

  get 'home' => 'clubs#index', as: :clubs
  post 'home' => 'clubs#create'
  get 'catalog' => 'clubs#catalog'
  resources :clubs do
    get 'tables' => 'tables#index', as: :tables
    get 'tables/:id' => 'tables#show', as: :table #contain оформить заказ button
    get 'tables/:id/edit' =>'tables#edit', as: :edit_table #shows orders
    get 'orders' => 'orders#index', as: :orders
    get 'orders/new' => 'orders#new', as: :new_order 
    post 'orders' => 'orders#create', as: :order_create
    get 'orders/:id/edit' => 'orders#edit', as: :edit_order
    put 'orders' => 'orders#update'
    get 'orders/:id' => 'orders#show', as: :order
    delete 'orders/:id' => 'orders#destroy'
    post 'orders/prepare' => 'orders#prepare', as: :prepare_order
    get 'tables_status' => 'clubs#tables_status', as: :tables_status
    resources :photos, only: [:create, :destroy]
    # post 'photos/:owner_type' => 'photos#create', as: :photo_create
    # delete 'photos/'
    post :rate, :on => :member
    resources :comments, only: [:create, :destroy]
    resources :news
  end
  post 'news/news_full' => 'news#news_full', as: :news_full
  resources :comments, only: [:create, :destroy]
  get 'users/profile', as: 'user_root'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#cap'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
