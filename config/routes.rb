Rails.application.routes.draw do

  get 'parametres/edit'
  post 'parametres/update'

  get 'questions/conjugaison'
  post 'questions/verification'
  get 'questions/vocabulaire'
  get 'questions', to: 'questions#lance', as: 'lance_questions'

  resources :vocabulaires
  get 'vocabulaire/sauve', to: 'vocabulaires#sauve', as: 'sauve_vocabulaire'

  devise_for :users
  resources :conjugaisons
  get '/conjugaisons/:id/copie', to: 'conjugaisons#copie', as: 'copie_conjugaison'
  get 'conjugaisons/sauve', to: 'conjugaisons#sauve', as: 'sauve_conjugaison'
  get 'conjugaisons/aligne', to: 'conjugaisons#aligne', as: 'aligne_conjugaison'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
root 'conjugaisons#index'

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
