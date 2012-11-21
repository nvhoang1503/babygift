Littlespark::Application.routes.draw do
  get "home/index"
  get "home/how_it_work"
  get "home/fqa"

  root :to => 'home#index'

end
