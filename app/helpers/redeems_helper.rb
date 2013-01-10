module RedeemsHelper
  def gender_options#(selected=nil)
    arr = []
    Baby::GENDER.each do |k,v|
      arr << [k.to_s.capitalize, v]
    end
    return arr
  end
end
