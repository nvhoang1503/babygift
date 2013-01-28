class Baby < ActiveRecord::Base
  GENDER = {
    :boy => 1,
    :girl => -1,
    :surprize => 0
  }

  attr_accessible :birthday, :user_id, :first_name, :gender, :last_name
  validates :first_name, :last_name, :birthday, :gender, :presence => { :message => "Can't be blank" }

  belongs_to :parent, :class_name => 'User', :foreign_key => :user_id
  has_one :plan, :class_name => 'Order', :foreign_key => :baby_id

  def fullname
    [self.first_name, self.last_name].join(' ')
  end
end
