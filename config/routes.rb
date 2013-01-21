Littlespark::Application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => 'sessions' }

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
      # get 'test'
    end
  end

  match 'my_account' => 'users#my_account', :via => [:get]
  resources :users, :only => [:edit, :update] do
    collection do
    end
    get 'index'
    get 'contact'
    put 'contact_update'
    get 'edit_password'
    put 'update_password'

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
      match 'create_update_gift' => 'gifts#create_update_gift', :via => [:put, :post]
      get 'step_2'
      put 'update_gift_plan'  #update  plan type for gift
      get 'step_3'
      put 'update_gift_billing' #update  billing for gift
      get 'step_4'
      post 'finish'
    end
  end

  resources :redeems, :only => [] do
    collection do
      get 'step_1'
      match 'create_update' => 'redeems#create_update', :via => [:put, :post]
      get 'step_2'
      get 'step_3'
      get 'step_3b'
      get 'reload_child'
      put 'create_child'
      put 'update_child' #update  child for redeem
      put 'update_redeem_shipping'
      put 'create_shipping' #update  billing for redeem
      get 'step_4'
      get 'step_5'
      post 'finish'
    end

  end
end
