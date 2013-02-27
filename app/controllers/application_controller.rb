class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    url = my_account_path
    if request.referer
      env = Rack::MockRequest.env_for request.referer
      req_referer = Rack::Request.new env
      if req_referer.path == url_for(:controller => '/enrolment', :action => :step_3, :only_path => true)
        url = step_4_enrolments_path(req_referer.params)
      end
    end
    url
  end

  def after_sign_out_path_for(resource_or_scope)
    if params[:go_to_page] == 'forget_pass'
      new_user_password_path
    # elsif params[:go_to_page] == 'admin_login'
    #   login_admins_path
    else
      root_path
    end
  end

end
