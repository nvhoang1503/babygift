module ApplicationHelper
  def enroll_steps_paths
    [ step_1_enrolments_path, step_2_enrolments_path, step_3_enrolments_path,
      step_4_enrolments_path, step_5_enrolments_path, finish_enrolments_path ]
  end

  def gift_steps_paths
    [ step_1_gifts_path, step_2_gifts_path, step_3_gifts_path, step_4_gifts_path, finish_gifts_path ]
  end

  def us_states_collection
    Country['US'].states.map { |k,v| [k, v['name']]}
  end

  def plan_detail(type, price)
    [number_to_currency(price), Order::TYPE_DURATION[type]].join('/')
  end
end
