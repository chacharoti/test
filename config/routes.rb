Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  if Rails.env == 'staging'
    api_subdomain = 'stagingapi'
    admin_subdomain = 'stagingadmin'
  else
    api_subdomain = 'api'
    admin_subdomain = 'admin'
  end

  constraints subdomain: admin_subdomain do
    mount RailsAdmin::Engine => '/'
  end

  constraints subdomain: api_subdomain do
    use_doorkeeper

    namespace :api, path: nil do
      namespace :v1 do
        resources :devices, only: [] do
          collection do
            post :register
          end
        end

        resources :users, only: [] do
          collection do
            post :forgot_password
            post :sign_up
            get :info
            get :email_is_available
            post :add_media
            post :update_profile_photo
            post :update_location
            get :nearby
          end
        end

        resources :posts, only: [:index, :create] do
          collection do
            get :load_new
            get :load_more
          end
          member do
            resources :comments, only: [:index, :create]
            resources :emotions, only: [:index, :create] do
              collection do
                post :remove
              end
            end
            get :followers
            post :follow
            post :unfollow
          end
        end

        resources :packets, only: [:index] do
        end

        resources :activities, only: [:index] do
        end

        resources :conversations, only: [:index] do
          collection do
            get :load_more
          end
        end
      end
    end
  end

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
