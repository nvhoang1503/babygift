Littlespark::Application.routes.draw do
  get "home/index"
  get "home/how_it_work"
  get "home/fqa"
  get "home/contact_us"
  root :to => 'home#index'

end
