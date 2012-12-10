class Baby < ActiveRecord::Base
  GENDER = {
    :boy => 1,
    :girl => -1,
    :surprize => 0
  }

  attr_accessible :birthday, :user_id, :first_name, :gender, :last_name
  validates_presence_of :first_name, :last_name

  belongs_to :parent, :class_name => 'User', :foreign_key => :user_id
end
