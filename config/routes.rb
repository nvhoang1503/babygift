Littlespark::Application.routes.draw do
  get "enrolment/step_1"
  get "enrolment/step_2"
  get "enrolment/step_3"
  get "enrolment/step_4"
  get "enrolment/step_5"
  get "enrolment/finish"
  post 'create_baby', :to => 'enrolment#create_baby'
  post 'create_plan', :to => 'enrolment#create_plan'

  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}

  root :to => 'home#index'

  get "home/index"
  get "home/how_it_work"
  get "home/fqa"
  get "home/contact_us"
  get "home/about_us"

  get 'curriculum', :to => 'home#curriculum'
  get 'kits', :to => 'home#kits'
  get 'fan_page', :to => 'home#fan_page'


end
