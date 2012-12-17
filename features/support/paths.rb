def path_to(page_name)
  case page_name
  when /kits page/ then
    kits_path
  when /home page/ then
    root_path
  when /gift recipient/ then
    gifts_step_1_path
  end
end
