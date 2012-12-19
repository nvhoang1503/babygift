class SessionsController < Devise::SessionsController
  ENROLMENT_RECEIVE = 'enrolment'

  def create
    custom_auth_options = auth_options
    if params[:submit_from] == ENROLMENT_RECEIVE
      custom_auth_options[:recall] = "enrolment#step_3"
    end
    resource = warden.authenticate!(custom_auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path(resource, params[:submit_from], params[:order_id])
  end

  protected
    def after_sign_in_path(resource, submit_from=nil, order_id=nil)
      if submit_from == ENROLMENT_RECEIVE
        step_4_enrolments_path(:order_id => order_id)
      else
        after_sign_in_path_for(resource)
      end
    end
end
