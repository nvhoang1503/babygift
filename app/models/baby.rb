class Baby < ActiveRecord::Base
  attr_accessible :birthday, :caretaker, :first_name, :gender, :last_name
  validates_presence_of :first_name, :last_name
  GENDER = {
    :boy => 1,
    :girl => -1,
    :surprize => 0
  }
end
