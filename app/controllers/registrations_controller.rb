class RegistrationsController < Devise::RegistrationsController
  ENROLMENT_RECEIVE = 'enrolment'
  REDEEM_RECEIVE = 'redeem'
  def create
    resource = build_resource
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        UserMailer.welcome_email(resource).deliver
        UserMailer.register_mail(resource).deliver
        ob_id = nil
        if params[:submit_from] == ENROLMENT_RECEIVE
          ob_id = params[:order_id]
        elsif
          params[:submit_from] == REDEEM_RECEIVE
          ob_id = params[:redeem_id]
        end
        respond_with resource, :location => after_sign_up_path_for(resource, params[:submit_from], params[:order_id])
        flash[:notice] = I18n.t('content.page.login.sign_up_successfully')
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
        render '/enrolment/step_3b'
      elsif params[:submit_from] == REDEEM_RECEIVE
        env = Rack::MockRequest.env_for request.referer
        req_referer = Rack::Request.new env
        @redeem = Redeem.find_by_id params[:redeem_id]
        @submit_from = REDEEM_RECEIVE
        render '/redeems/step_3b'
      else
        respond_with resource
      end
    end
  end

  protected
    def after_sign_up_path_for(resource, submit_from, ob_id)
      if submit_from == ENROLMENT_RECEIVE
        step_4_enrolments_path(:order_id => ob_id)
      elsif submit_from == REDEEM_RECEIVE
        step_3b_redeems_path(:redeem_id => ob_id)

      else
        after_sign_in_path_for(resource)
      end
    end
end
