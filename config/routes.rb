Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  # root 'application#hello'
  # どうしてrootは/出なくて#なのか？
    
  # get 'static_pages/home'
  # => StaticPages#home
  
  # get 'static_pages/help'
  get  '/help',    to: 'static_pages#help'
  
  # get 'static_pages/about'
  get  '/about',   to: 'static_pages#about'
  
  # get 'static_pages/contact'
  get  '/contact', to: 'static_pages#contact'
  # -> contact_path, contact_urlが使えるように
  
  get '/signup',   to: 'users#new'
  
end
