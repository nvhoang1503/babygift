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
    @plan.price = BabyPlan::PRICE[@plan.type] if params[:plan] && params[:plan].has_key?('type')
    if @plan.save
      redirect_to enrolment_step_3_path
    else
      flash[:error] = I18n.t('content.page.enroll_2.plan_missing')
      render enrolment_step_2_path
    end
  end

  def step_3
  end

  def step_4
  end

  def step_5
  end

  def finish
  end
end
