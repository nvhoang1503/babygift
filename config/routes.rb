Littlespark::Application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => 'sessions'}

  root :to => 'home#index'

  resources :home, :as => :homes, :only => [:index] do
    collection do
      # get 'index'
      get 'how_it_work'
      get 'fqa'
      get 'contact_us'
      get 'about_us'
      get 'term'
      get 'curriculum'
      get 'kits'
      get 'fan_page'
    end
  end

  resources :enrolment, :as => 'enrolments', :path => 'enrollment', :only => [] do
    collection do
      get 'step_1'
      get 'step_2'
      get 'step_3'
      get 'step_4'
      get 'step_5'
      post 'finish'
      put 'update_order_shipping', :as => :shipping_info
      match 'enroll_baby' => 'enrolment#enroll_baby', :via => [:post, :put], :as => :baby
      match 'enroll_plan' => 'enrolment#enroll_plan', :via => [:post, :put], :as => :plan
    end
  end

  resources :gifts, :only => [] do
    collection do
      get 'step_1'
      get 'step_2'
      get 'step_3'
      get 'step_4'
      get 'finish'
      match 'update_gift' => 'gifts#update_gift', :via => [:put, :post]
    end
  end
end
