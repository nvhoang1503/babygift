module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /kits page/ then
      kits_homes_path
    when /home page/ then
      root_path
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
    end
  end
end

World(NavigationHelpers)
