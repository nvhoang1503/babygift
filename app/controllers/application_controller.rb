class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    if request.env["HTTP_REFERER"] == url_for(:controller => '/enrolment', :action => :step_3, :only_path => false)
      enrolment_step_4_path
    else
      root_path
    end
  end
end
