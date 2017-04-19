Rails.application.routes.draw do
  get '/' => 'ideas#new'
  get '/ideas/dash' => 'ideas/dash'
  post '/ideas/create' =>'ideas#create'
  post '/ideas/login' =>'ideas#login'
  post '/ideas/create_idea' =>'ideas#create_idea'
  post '/ideas/destroy_idea/:id' =>'ideas#destroy_idea'
  post '/ideas/create_like' =>'ideas#create_like'
  post '/ideas/destroy_like/:id/:id2' =>'ideas#destroy_like'
  get '/ideas/show_user/:id' =>'ideas#show_user'
  get '/ideas/show_idea/:id' =>'ideas#show_idea'
  post '/ideas/logout' => 'ideas#logout'
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
