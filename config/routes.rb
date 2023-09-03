Rails.application.routes.draw do

  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'posts#index', as: 'index_post'

  # PostsController
  get 'posts/new', to: 'posts#new', as: 'new_post'
  #2-9 追加
  post 'posts/new', to: 'posts#create', as: 'create_post'
  # 2-12
  get 'posts/edit/:id', to: 'posts#edit', as: 'edit_post'
  post 'posts/edit/:id', to: 'posts#update', as: 'update_post'
  delete 'posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post'

  # 2-13 追加
  # CommentsController
  get 'posts/show/:post_id/comments/new', to: 'comments#new', as: 'new_comment'
  post 'posts/show/:post_id/comments/new', to: 'comments#create', as: 'create_comment'
  
  #TopicsController
  get 'topics/new', to: 'topics#new', as: 'new_topic'
  post 'topics/new', to: 'topics#create', as: 'create_topic'
  get 'topics/edit/:id', to: 'topics#edit', as: 'edit_topic'
  post 'topics/edit/:id', to: 'topics#edit', as: 'update_topic'

  # 2-12
  delete 'topics/destroy/:id', to: 'topics#destroy', as: 'destroy_topic'
  get 'topics/index', to: 'topics#index', as: 'index_topic'
end
