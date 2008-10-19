module ApplicationHelper

  def tab_li_attributes(name)
    attributes = {}
    attributes[:class] = 'current' if controller.controller_name == name
    attributes
  end

  def tab_for(name, url = nil)
    url ||= send("#{name.downcase}_path")
    content_tag :li, tab_li_attributes(name) do
      link_to name.capitalize, url
    end
  end

end
