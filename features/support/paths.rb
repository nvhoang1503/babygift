World(ApplicationHelper)
World(ActionView::Helpers::NumberHelper)

module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /kits page/ then
      kits_homes_path
    when /home page/ then
      root_path
    when /login page/ then
      new_user_session_path
    when /gift recipient/ then
      step_1_gifts_path
    when /gift monthly plan with gift of sender "([^"]*)"/ then
      ob = Gift.find_by_sender_email($1)
      step_2_gifts_path(:gift_id => ob.id)
    when /gift billing with gift of sender "([^"]*)"/ then
      ob = Gift.find_by_sender_email($1)
      step_3_gifts_path(:gift_id => ob.id)
    when /gift payment with gift of sender "([^"]*)"/ then
      ob = Gift.find_by_sender_email($1)
      step_4_gifts_path(:gift_id => ob.id)
    when /gift redeem page/ then
      step_1_redeems_path
    when /gift monthly plan with gift of sender "([^"]*)"/ then
      ob = Gift.find_by_sender_email($1)
      step_2_gifts_path(:gift_id => ob.id)
    when /gift redeem your child page with the redeem of sender "([^"]*)"/ then
      ob =  Gift.find_by_sender_email($1)
      step_3_redeems_path(:redeem_id => ob.id)
    when /gift redeem your updating child page with the redeem of sender "([^"]*)"/ then
      ob =  Gift.find_by_sender_email($1)
      step_3b_redeems_path(:redeem_id => ob.id)
    when /gift redeem Shipping page with the redeem of sender "([^"]*)"/ then
      ob =  Gift.find_by_sender_email($1)
      step_4_redeems_path(:redeem_id => ob.id)
    when /gift redeem Payment page with the redeem of sender "([^"]*)"/ then
      ob =  Gift.find_by_sender_email($1)
      step_5_redeems_path(:redeem_id => ob.id)
    when /your account page with the first gift code "([^"]*)"/ then
      ob = Gift.find_by_gift_code($1)
      step_2_redeems_path(:redeem_id => ob.id)
    when /your child 1 page with the first gift code "([^"]*)"/ then
      ob = Gift.find_by_gift_code($1)
      step_3_redeems_path(:redeem_id => ob.id)
    when /contact information page/ then
      contact_users_path
    when /change password page/ then
      edit_password_users_path
    when /order history page/ then
      order_history_users_path
    end
  end
end

World(NavigationHelpers)
