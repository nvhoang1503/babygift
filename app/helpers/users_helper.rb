module UsersHelper
  # def get_recipient_name(baby_id)
  #   baby = Baby.find_by_id(baby_id)
  #   user = baby.parent
  #   name = user.first_name + " "+ user.last_name
  #   return name
  # end

  def get_child_name(baby_id)
    baby = Baby.find_by_id(baby_id)
    name = ""
    if !( baby.first_name.nil? &&  baby.last_name.nil?)
      name = [baby.first_name , baby.last_name].join(" ")
    end
    return name
  end

  # user_plan_babies: from
  def child_plan_options(selected=nil)
    babies = current_user.enroll_n_redeem_babies
    arr = []
    babies.each { |b|
      arr << [b.first_name, b.id, {'data-plan-id' => b.plan_id, 'data-enroll' => b.is_enroll_plan, 'data-redeem' => b.is_redeem_plan}]
    }

    options_for_select(arr, selected)
  end

end
