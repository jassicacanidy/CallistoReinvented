Rails.application.routes.draw do

  

  devise_for :users, :path_names => 
  { :sign_up => "register" }
  

  resources :profile
  root :to => 'home#index'  

  # get '/' => 'users#login'
  resources :companies


  get 'users/login' => 'users#login', :as => :home
  # get 'users/register' => 'users#register', :as => :register
  # get 'users/profile' => 'users#profile', :as => :student_profile
  get 'users/dashboard' => 'users#dashboard', :as => :dashboard
  get 'users/jobs' => 'users#jobs', :as => :jobs
  get 'users/post' => 'users#post', :as => :post
  get 'users/new' => 'users#new', :as => :new_user
  get 'users/create_post'    => 'users#create_post', :as => :create_post
  get 'users/initialize_tags' => 'users#initialize_tags', :as => :user_initialize_tags
  post 'users/fill_tags' => 'users#fill_tags', :as => :user_fill_tags
  post 'users/reset_tags' => 'users#reset_tags', :as => :user_reset_tags
  
  get 'company/profile' => 'company#profile', :as => :com_profile
  get 'company/jobs' => 'company#jobs', :as => :com_jobs
  get 'company/register' => 'company#register', :as => :com_register

  get '/company/:id'            => 'companies#show'
  get '/posting/all'            => 'jobposting#show_all'
  get '/posting/posting_id/:id' => 'jobposting#show_by_posting_id'
  get '/posting/company_id/:id' => 'jobposting#show_by_company_id'
  get '/posting/search'         => 'jobposting#search', :as => :search
  get '/posting/advanced_search' => 'jobposting#advanced_search', :as => :advanced_search

  post '/posting/add'           => 'jobposting#add'
  post '/company/add'           => 'companies#add', :as => :add
  post '/company/create'        => 'companies#add'
  post '/TESTAPI/resetFixture'  => 'companies#resetFixture'

  put '/jobposting/posting_id/:id' => 'jobposting#update', :as => :posting_update
  put '/jobposting/click/:id' => 'jobposting#click', :as => :click
  put '/jobposting/bookmark/:id' => 'jobposting#bookmark', :as => :bookmark
  get '/jobposting/bookmarks' => 'jobposting#retrieve_bookmarks', :as => :retrieve_bookmarks
  get '/jobposting/recommend' => 'jobposting#recommend', :as => :recommend

  post '/events/createEvent'       => 'events#create_event', :as => :create_event
  get '/events/getEvent/:id'       => 'events#get_event'
  post '/events/editEvent/:id'     => 'events#edit_event'
  delete '/events/deleteEvent/:id' => 'events#delete_event'
  get '/events/search/'            => 'events#search'
  #get '/events/:id'            => 'events#show'
  resources :events

  # debugging routes
  get '/profile/profile' => 'profile#index'

  delete '/posting/:id' => 'jobposting#delete'

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
