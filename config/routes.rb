Rails.application.routes.draw do

  get 'landing/index'
  get 'legs/index'

  resources :emptylegs, except: [:new, :edit]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { 
    registrations: "users/registrations",
    sessions: "users/sessions",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  authenticated :user do
    root 'landing#index', as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end

  #Citrus payment test routing

  get "test/index"
  post "test/index"
  post "test/callback"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'test#index'

  resources :users
  resources :cities, except: [:new, :edit]
  resources :contacts
  resources :unlok_air do
  end
  resources :bookings, except: [:edit] do
    collection do
      get 'thankyou'
    end
  end
  resources :planes, except: [:new, :edit]
  resources :items
  resources :home

  #Payment related path
  get  "/bill_generate" => "form#bill_generate"
  post "/returnUrl" => "form#submit"
  get  "/returnUrl" => "form#submit"

  get  '/profile', to: 'profiles#edit', as: 'profile'
  match  '/profile/save', to: 'profiles#save', via: :all, as: 'save_profile'
  get  '/unlokshop', to: 'home#unlokshop'
  get  '/unlokfinance', to: 'home#unlokfinance'
  get  '/settings', to: 'home#settings'
  get  '/comingsoon', :to => redirect('/comingsoon.html')
  get  '/about-us', to: 'home#about_us', as: 'about_us'
  

  #API help path
  get 'api_help' => "api_help#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  #all api path
  namespace :api , :defaults => { :format => 'json' } do
    scope :module => :v1 do
      post 'register', to: 'users#create',  :as => :signup
      post 'login', to: 'sessions#create',  :as => :signin
      post 'logout', to: 'sessions#destroy', :as => :logout
      post 'signup_with_facebook_and_google', to: 'users#signup_with_facebook_and_google',  :as => :signup_with_facebook_and_google
      post 'forgot_password', to: 'passwords#new', :as => :forgot_password
      post 'main_category', to: 'items#main_category'
      post 'sub_category', to: 'items#sub_category'
      post 'all_items', to: 'items#all_items'
      post 'category_items', to: 'items#category_items'
      post 'sub_category_items', to: 'items#sub_category_items'
      # post 'change_password', to: 'passwords#update', :as => :change_password
    end
  end
end
