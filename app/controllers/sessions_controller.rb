class SessionsController < Devise::SessionsController
  ENROLMENT_RECEIVE = 'enrolment'
  REDEEM_RECEIVE = 'redeem'
  ADMIN_RECEIVE = 'admin'

  def create
    custom_auth_options = auth_options
    ob_id = nil
    if params[:submit_from] == ENROLMENT_RECEIVE
      custom_auth_options[:recall] = "enrolment#step_3"
      ob_id = params[:order_id]
    elsif params[:submit_from] == REDEEM_RECEIVE
      custom_auth_options[:recall] = "redeems#step_2"
      ob_id = params[:redeem_id]
    elsif params[:submit_from] == ADMIN_RECEIVE
      custom_auth_options[:recall] = "admin#login"
    end
    resource = warden.authenticate!(custom_auth_options)
    if params[:submit_from] == ADMIN_RECEIVE
      if resource.is_admin
        set_flash_message(:notice, :signed_in) if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_in_path(resource, params[:submit_from], ob_id)
      else
        sign_out(resource)
        redirect_to login_admins_path(:flag => false)
      end
    else
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path(resource, params[:submit_from], ob_id)
    end
  end

  protected
    def after_sign_in_path(resource, submit_from=nil, ob_id=nil)
      if submit_from == ENROLMENT_RECEIVE
        step_4_enrolments_path(:order_id => ob_id)
      elsif submit_from == REDEEM_RECEIVE
        step_3b_redeems_path(:redeem_id => ob_id)
      elsif submit_from == ADMIN_RECEIVE
        admins_path
      else
        after_sign_in_path_for(resource)
      end
    end
end
