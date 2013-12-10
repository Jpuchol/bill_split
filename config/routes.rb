BillSplit::Application.routes.draw do
  resources :groups do
      get :group_id, :user_id
  end
  resources :bills do
      get :bill_id, :user_id
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy ]
  resources :bills,    only: [:create, :edit, :destroy]
  resources :members,  only: [:create, :destroy ]
  resources :groups
  resources :bill_users, only: [:create, :destroy]

  root 'static_pages#home'
  match '/about',                 to: 'static_pages#about', via: 'get'
  match '/blog',                  to: 'static_pages#blog',  via: 'get'
  match '/help',                  to: 'static_pages#help',  via: 'get'
  match '/help/signup',           to: 'static_pages#signup',  via: 'get'
  match '/help/signin',           to: 'static_pages#signin',  via: 'get'
  match '/help/change_settings',  to: 'static_pages#change',  via: 'get'
  match '/help/create_bill',      to: 'static_pages#createBill',  via: 'get'
  match '/help/create_group',      to: 'static_pages#createGroup',  via: 'get'
  match '/help/remove_group',      to: 'static_pages#remove',  via: 'get'
  match '/help/manage_group',      to: 'static_pages#manage',  via: 'get'
  match '/help/add_users_to_bill', to: 'static_pages#addUser',  via: 'get'
  match '/signup',                to: 'users#new',          via: 'get'
  match '/signin',                to: 'sessions#new',       via: 'get'
  match '/signout',               to: 'sessions#destroy',   via: 'delete'
  match '/newgrp',                to: 'groups#new',         via: 'get'
  match '/groups/:id',             to: 'bills#create',       via: 'post'
  match '/money',                 to: 'static_pages#money', via: 'get'

#  match '/newbill',  to: 'bills#new',       via: 'post'


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
