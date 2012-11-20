Littlespark::Application.routes.draw do
  get "home/index"
  get "home/how_it_work"
  root :to => 'home#index'

  
end
