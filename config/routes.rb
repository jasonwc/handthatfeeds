Handthatfeeds::Application.routes.draw do
  resources :users, only: [:index, :show], path: :user 
  #resources :users

  devise_for :users

  root to: "static_pages#home"

  get "users/index", to: "users#index", as: :users

  get "/your_legislators", to: "legislators#your_legislators", as: :your_legislators
  get "legislators/index", to: "legislators#index", as: :legislators
  get "legislators/show/:crp_id", to: "legislators#show", as: :legislator
  post "legislator/follow", to: "legislators#follow", as: :follow_legislator
  delete "legislator/unfollow", to: "legislators#unfollow", as: :unfollow_legislator
  get "/about", to: "static_pages#about", as: :about

  get "/contact", to: "contact#new", as: :contact
  post "/contact", to: "contact#create", as: :contact

  resources :activities

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
