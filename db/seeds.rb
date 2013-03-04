# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(:email => "admin@littlespark.com")
  User.create({
             :email => "admin@littlespark.com",
             :password => "littlesparkadmin",
             :password_confirmation => "littlesparkadmin",
             :is_admin => true
           })
else
  admin = User.find_by_email("admin@littlespark.com")
  admin.update_attribute(:is_admin,true)
end
