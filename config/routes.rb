Rails.application.routes.draw do
  get 'guest/visit'

  resources :user do
    collection do
      get 'login'
      post 'create'
      get 'check_account'
      get 'check_nickname'
      get 'info'
      post 'logout'
      post 'update'
    end
  end

  resources :guest do
    collection do
      get 'test'
      post 'test'
      put 'test'
      delete 'test'
    end
  end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  namespace :api do
    resources :guest do
      collection do
        get 'test'
        post 'test'
        put 'test'
        delete 'test'
      end
    end
  end

  namespace :web_api do
    resources :guest do
      collection do
        get 'test'
        post 'test'
        put 'test'
        delete 'test'
      end
    end

    resources :schedule do
      collection do
        post 'this_week'
        post 'next_week'
        get 'this_week'
        get 'next_week'
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'guest#visit'

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
