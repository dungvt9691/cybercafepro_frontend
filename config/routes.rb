Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'customer_pages#customer_ordering'

  resources :users
  resource :sessions, only: [:new, :create, :destroy]
  resources :registrations

  resources :manager_pages,only: [] do
    collection do
      get "user_list"
      get "menu_item_list"
      get "payment_list"
      get "sale_list"
      get "shift_list"
    end
  end

  resources :customer_pages,only: [] do
    collection do
      get  "customer_ordering"
      post "create_sale"
    end
  end

  resources :waiter_pages,only: [] do
    collection do
      get "sale_list"
      get "go_for_payment"
      get "verify_payment"
      get "go_deliver"
      get "done_deliver"
    end
    member do
      get "sale_details"
    end
  end

  resources :chief_pages,only: [] do
    collection do
      get "cooking_list"
      get "start_cooking"
      get "done_cooking"
    end
  end

  resources :bartender_pages,only: [] do
    collection do
      get "cooking_list"
      get "start_cooking"
      get "done_cooking"
    end
  end

  resources :cashier_pages,only: [] do
    member do
      get "sale_details"
    end
    collection do
      get "sale_list"
      get "save_sale"
      get "saved_sales"
    end
  end


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
