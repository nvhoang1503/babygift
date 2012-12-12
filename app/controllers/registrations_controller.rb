class RegistrationsController < Devise::RegistrationsController
  ENROLMENT_RECEIVE = 'enrolment'
  def create
    resource = build_resource
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        UserMailer.welcome_email(resource).deliver
        UserMailer.register_mail(resource).deliver
        respond_with resource, :location => after_sign_up_path_for(resource, params[:submit_from], params[:order_id])
        flash[:notice] = "Sign up successfully"
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      if params[:submit_from] == ENROLMENT_RECEIVE
        env = Rack::MockRequest.env_for request.referer
        req_referer = Rack::Request.new env
        @order = Order.find_by_id params[:order_id]
        @submit_from = ENROLMENT_RECEIVE
        render enrolment_step_3_path(:order_id => req_referer.params[:order_id])
      else
        respond_with resource
      end
    end
  end

  protected
    def after_sign_up_path_for(resource, submit_from, order_id)
      if submit_from == ENROLMENT_RECEIVE
        enrolment_step_4_path(:order_id => order_id)
      else
        after_sign_in_path_for(resource)
      end
    end
end
