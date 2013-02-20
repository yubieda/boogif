BasicSite::Application.routes.draw do
  
  namespace :admin do 
    resources :users do
      collection do
        get 'export'
      end
    end
  end

  match '/scrapper', to: 'scrapper#index', :as => 'scrapper'
  match '/scrapped_images', to: 'scrapper#scrapped_images', :as => 'scrapped_images'

  root to: "home#home"

  get "info_pages/about"

  get "info_pages/help"

  get "info_pages/terms"

  get "info_pages/contact"

  get "info_pages/howToUse"
  
  
  resources :users do
    # resources :connections
  end
  resources :events
  resources :sessions, only: [:new, :create, :destroy]
  resources :user_posts, only: [:create, :destroy]
  resources :items, only: [:create, :destroy, :update]
  
  match "/home", to: "home#home"
  match "/sign_in", to: "sessions#new"
  match "/sign_up", to: "users#new"
  match "/sign_out", to: "sessions#destroy", via: :delete
  match "/reset_password", to: "users#reset_password"
  match "/add_gift", to: "items#new"
  match "/purchase_item", to: "items#purchase"
  match "/unpurchase_item", to: "items#unpurchase"

  match "/settings", to: "users#edit"

  match "profile/connections", to: "profile#connections"
  match "profile/invites", to: "profile#invites"

  match "/create_connection", to: "connections#create"
  match "/confirm_connection", to: "connections#confirm"
  match "/delete_connection", to: "connections#delete"
  
  match"/how_to_use", to: "info_pages#howToUse"
  match"/about", to: "info_pages#about"
  match"/contact", to: "info_pages#contact"
  match"/help", to: "info_pages#help"
  match"/terms", to: "info_pages#terms"
  match"/privacy", to: "info_pages#privacy"
  match"/contact", to: "info_pages#contact"
  match"/online_stores", to: "info_pages#onlineStores"
  
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
