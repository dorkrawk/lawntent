Rails.application.routes.draw do
  devise_for :users

  root 'pages#index'

  resources :post_templates
  get '/login' => 'pages#login', as: :login

  get '/:id/posts/:limit' => 'post_collections#posts', as: :post_collection_posts
  get '/:id' => 'post_collections#show', as: :post_collection
  resources :post_collections, :except => ['show']

  get '/:collection_id/new_post' => 'posts#new', as: :new_post
  post ':collection_id/posts' => 'posts#create',  as: :create_post
  get '/:collection_id/:post_id/edit' => 'posts#edit', as: :edit_post
  patch ':collection_id/posts/:post_id' => 'posts#update',  as: :update_post
  get '/:collection_id/:post_id' => 'posts#show', as: :post
  get '/:collection_id/:post_id/preview' => 'posts#preview', as: :post_preview


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
