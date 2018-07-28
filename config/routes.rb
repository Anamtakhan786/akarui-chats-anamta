Rails.application.routes.draw do
   #get 'conversations/index'
   devise_for :users

   devise_scope :user do
        authenticated :user do
             root 'conversations#index', as: :authenticated_root
         end

        unauthenticated do
            root 'devise/sessions#new', as: :unauthenticated_root
         end
    end

    resources :users, only: [:index]
	  resources :personal_messages, only: [:new, :create]
    #resources :personal_messages, only: [:create]
    resources :conversations, only: [:index, :show]
end