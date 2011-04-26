PortfolioViny::Application.routes.draw do
  namespace :admin do
    match 'login' => 'user_session#new', :as => :login
    match 'logout' => 'user_session#destroy', :as => :logout
    resource :user_session, :only => [:show, :new, :create, :destroy],
             :controller => :user_session
    resource :user, :only => [:edit, :update],
             :controller => :user
    resources :static_contents, :only => [:index, :show, :edit, :update]
    resources :external_links
    resources :achievements
    resources :resumes
  end

  root :to => 'home#index'
  match 'portfolio/:section' => 'portfolio#index', :as => :portfolio_section
  match 'portfolio/:section/:subsection/:title' => 'portfolio#show',
    :as => :portfolio_achievement
  match 'links' => 'external_links#index', :as => :external_links

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
