Rails.application.routes.draw do
  root 'mix#index'

  get 'swap', :to => 'swap#index'
  get 'mix', :to => 'mix#index'

  namespace :api do
    namespace :v1 do
      post 'mix', :to => 'mix#create'
      post 'swap', :to => 'swap#create'
    end
  end
end
