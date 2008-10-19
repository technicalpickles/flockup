module ApplicationHelper

  def tab_li_attributes(name)
    attributes = {}
    if controller.controller_name == name.underscore || controller.controller_name.singularize == name.underscore
      attributes[:class] = 'current'
    end
    attributes
  end

  def tab_for(name, url = nil)
    url ||= send("#{name.downcase}_path")
    content_tag :li, tab_li_attributes(name) do
      link_to name.capitalize, url
    end
  end

end
