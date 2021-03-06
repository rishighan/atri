Atri::Application.routes.draw do

  get "reportcontroller/new"
  get "reportcontroller/callback"
  devise_for :users
  #get "home/index"

resources :categories do
  collection do
    get :autocats
  end
end

resources :posts do
  resources :attachments

  collection do
    get :autocomplete
    # all posts listing
    get 'all' => 'posts#allposts'
  end
end

# sitemap
get '/sitemap.:format' => "home#sitemap"

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
get  'haiku' => 'home#haiku'
root 'home#index'

#all other static routes
#projects
get 'post/:id' => 'home#article', as: :article
get 'projects' => 'home#projects'
get 'project/:id' => 'home#project', as: :project
get 'colophon' => 'home#colophon'
get 'archive'  => 'home#archive'
get 'photolog' => "home#photolog"
get 'trampoline' => "home#trampoline"
get 'trampoline/:id' => "home#article", as: :scrap


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
