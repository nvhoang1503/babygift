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
