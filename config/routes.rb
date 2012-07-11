Ferdinand::Application.routes.draw do
  devise_for :designers

  resources :authentications

  devise_for :users, :controllers => {:registrations => 'registrations'}

  resources :locations
  resources :pageobjects
  resources :pages
  resources :campaigns
  resources :companies
  
  match '/users/auth/:provider/callback', :to => 'authentications#create'
  match 'publish', :to => 'campaigns#publish'
  match 'add_new_page', :to => 'campaigns#add_new_page'
  get 'make_favorite', :to => 'campaigns#make_favorite'
  get 'three_latest', :to => 'ferdinand_start#three_latest'
  get 'object_showcase', :to => 'ferdinand_start#object_showcase'
  root :to => "ferdinand_start#index"
end
