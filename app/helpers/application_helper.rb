module ApplicationHelper

  def tab_link_attributes(name)
    attributes = {}
    attributes[:class] = 'current' if controller.controller_name == name
    attributes
  end

  def tab_for(name, url = nil)
    url ||= send("#{name.downcase}_path")
    "<li>#{link_to name.capitalize, url, tab_link_attributes(name)}</li>"
  end

end
