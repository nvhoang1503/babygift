class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    env = Rack::MockRequest.env_for request.referer
    req_referer = Rack::Request.new env
    if req_referer.path == url_for(:controller => '/enrolment', :action => :step_3, :only_path => true)
      step_4_enrolments_path(req_referer.params)
    else
      root_path
    end
  end
end
