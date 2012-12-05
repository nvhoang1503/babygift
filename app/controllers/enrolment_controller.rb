class EnrolmentController < ApplicationController
  def step_1
    @child = Baby.new
  end
  def create_baby
    birthday = params[:child][:birthday]
    params[:child][:birthday] = Date.strptime(birthday, '%m/%d/%Y') if birthday.present?
    @child = Baby.new params[:child]
    if @child.save
      redirect_to enrolment_step_2_path
    else
      render enrolment_step_1_path
    end
  end

  def step_2
    @plan = BabyPlan.new
  end

  def create_plan
    @plan = BabyPlan.new params[:plan]
    @plan.baby = Baby.first #temp
    @plan.price = BabyPlan::PRICE[@plan.plan_type] if params[:plan] && params[:plan].has_key?('plan_type')
    if @plan.save
      redirect_to enrolment_step_3_path
    else
      flash[:error] = I18n.t('content.page.enroll_2.plan_missing')
      render enrolment_step_2_path
    end
  end

  def step_3
    # return redirect_to enrolment_step_4_path if user_signed_in?

  end

  def step_4
    return redirect_to enrolment_step_3_path unless user_signed_in?
    @plan = BabyPlan.first
    @plan.build_shipping_address
    @plan.build_billing_address
  end

  def update_plan
    ship_to_billing = params[:plan].delete :ship_to_billing
    @plan = BabyPlan.first #temp
    if @plan.update_attributes params[:plan]
      redirect_to enrolment_step_5_path
    else
      render enrolment_step_4_path
    end
  end

  def step_5
    return redirect_to enrolment_step_3_path unless user_signed_in?
  end

  def finish
    user = current_user
    UserMailer.enroll_email(user).deliver
  end
end
