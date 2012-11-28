module EnrolmentHelper
  def gender_images_options
    [
      [1, '<div class="icon-gender boy pull-left"></div>'.html_safe] ,
      [-1, '<div class="icon-gender girl pull-left"></div>'.html_safe],
      [0, '<div class="icon-gender surprize pull-left"></div>'.html_safe]
    ]
  end
end
