module ApplicationHelper
  def enroll_steps_paths
    [ enrolment_step_1_path, enrolment_step_2_path, enrolment_step_3_path,
      enrolment_step_4_path, enrolment_step_5_path, enrolment_finish_path ]
  end

  def us_states_collection
    Country['US'].states.map { |k,v| [k, v['name']]}
  end
end
