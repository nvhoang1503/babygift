Littlespark::Application.routes.draw do

  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => 'sessions'}

  root :to => 'home#index'

  get "home/index"
  get "home/how_it_work"
  get "home/fqa"
  get "home/contact_us"
  get "home/about_us"
  get "home/term"

  get 'curriculum', :to => 'home#curriculum'
  get 'kits', :to => 'home#kits'
  get 'fan_page', :to => 'home#fan_page'


  get 'enrolment/step_0'
  get "enrolment/step_1"
  get "enrolment/step_2"
  get "enrolment/step_3"
  get "enrolment/step_4"
  get "enrolment/step_5"
  post "enrolment/finish"
  post 'enroll_baby', :to => 'enrolment#enroll_baby'
  put 'enroll_baby', :to => 'enrolment#enroll_baby'
  post 'enroll_plan', :to => 'enrolment#enroll_plan'
  put 'enroll_plan', :to => 'enrolment#enroll_plan'
  put 'update_order_shipping', :to => 'enrolment#update_order_shipping'

  resources :gifts, :only => [] do
    collection do
      get 'step_1'
      get 'step_2'
    end
  end
end
