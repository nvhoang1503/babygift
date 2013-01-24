module UsersHelper
  def get_recipient_name(baby_id)
    baby = Baby.find_by_id(baby_id)
    user = baby.parent
    name = user.first_name + " "+ user.last_name
    return name
  end

  def get_child_name(baby_id)
    baby = Baby.find_by_id(baby_id)
    name = baby.first_name + " " + baby.last_name
    return name
  end
end
