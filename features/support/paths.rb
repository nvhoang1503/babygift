module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /kits page/ then
      kits_path
    when /home page/ then
      root_path
    when /gift recipient/ then
      step_1_gifts_path
    end
  end
end

World(NavigationHelpers)
