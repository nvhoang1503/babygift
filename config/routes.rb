Littlespark::Application.routes.draw do
  get "home/index"
  get "home/how_it_work"
  get "home/fqa"
  get "home/contact_us"
  get "home/about_us"
  root :to => 'home#index'
  get 'cirriculum', :to => 'home#cirriculum'
  get 'about_us', :to => 'home#about'

end
