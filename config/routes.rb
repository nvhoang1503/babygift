Littlespark::Application.routes.draw do
  get "home/index"
  get "home/how_it_work"
  get "home/faq"

  root :to => 'home#index'

  
end
