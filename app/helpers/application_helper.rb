module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "John's Movies", :class => "round")
  end
end
