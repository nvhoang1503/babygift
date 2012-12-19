module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /kits page/ then
      kits_path
    when /home page/ then
      root_path
    when /gift recipient/ then
      step_1_gifts_path
    when /gift monthly plan/ then
      step_2_gifts_path
    when /gift billing/ then
      step_3_gifts_path
    when /gift payment/ then
      step_4_gifts_path
    end
  end
end

World(NavigationHelpers)
