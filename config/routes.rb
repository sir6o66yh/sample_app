Rails.application.routes.draw do
  root 'static_pages#home'
  # root 'application#hello'
  # どうしてrootは/出なくて#なのか？
    
  get 'static_pages/home'
  # => StaticPages#home
  
  get 'static_pages/help'
  # => StaticPages#help
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  
  get 'static_pages/about'
  
end
