module ApplicationHelper

  def icon_link_to(icon, name=nil, options=nil, html_options=nil, &block)
    link_to(options, html_options) do
      icon("#{icon} fa-2x", title: name)
    end
  end

  def format_time(datetime)
    datetime.strftime('%k:%M:%S')
  end

  def format_date_time(datetime)
    datetime.strftime('%Y.%m.%d %k:%M:%S')
  end

end
