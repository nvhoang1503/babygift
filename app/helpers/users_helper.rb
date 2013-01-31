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



end
