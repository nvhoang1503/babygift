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

  resources :enrolment, :as => 'enrolments', :path => 'enrollment', :only => [] do
    collection do
      get 'step_1'
      get 'step_2'
      get 'step_3'
      get 'step_4'
      get 'step_5'
      post 'finish'
      put 'update_order_shipping'
      match 'enroll_baby' => 'enrolment#enroll_baby', :via => [:post, :put], :as => :baby
      match 'enroll_plan' => 'enrolment#enroll_plan', :via => [:post, :put]
    end
  end

  resources :gifts, :only => [] do
    collection do
      get 'step_1'
      get 'step_2'
      get 'step_3'
      get 'step_4'
      get 'finish'
    end
  end
end
