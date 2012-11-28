Littlespark::Application.routes.draw do
  get "enrolment/step_1"
  get "enrolment/step_2"
  get "enrolment/step_3"
  get "enrolment/step_4"
  get "enrolment/step_5"
  get "enrolment/finish"

  devise_for :users

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
