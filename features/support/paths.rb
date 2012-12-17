def path_to(page_name)
  case page_name
  when /kits page/ then
    kits_path
  when /home page/ then
    root_path
  else
    root_path
  end
end
