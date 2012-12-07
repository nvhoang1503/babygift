module CustomizedHelper
  # Usage:
  #   customized_link_to 'text', 'link', :class => '', :id => '',
  #     :wrap_tag => ['li', :id => '', :class => '', ...],
  #     :active_class => 'selected', :active_at => [path_1, path_2....]
  def customized_link_to(*arg)
    text = arg[0]
    path = arg[1]
    options = arg.extract_options!.as_json
    options['href'] = path

    active_class = (options.has_key?('active_class') && options['active_class'].present?) ? options.delete('active_class') : 'active'
    active_paths = options.has_key?('active_at') ? options.delete('active_at').append(path).uniq : [path]

    if options.has_key? 'wrap_tag'
      wrap_tag_options = options.delete 'wrap_tag'
      wrap_tag = wrap_tag_options.first
      wrap_html_options = wrap_tag_options.extract_options!
    end

    if wrap_tag
      link = content_tag :a, text, options
      wrap_class = wrap_html_options.has_key?('class') ? wrap_html_options['class'] : ''
      wrap_html_options['class'] = [wrap_class, active_class].join(' ') if active_paths.index(request.path)
      return content_tag wrap_tag, link, wrap_html_options
    else
      link_class = options.has_key?('class') ? options['class'] : ''
      options['class'] = [link_class, active_class].join(' ') if active_paths.index(request.path)
      return content_tag :a, text, options
    end
  end
end
