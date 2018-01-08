module ApplicationHelper

  def icon_link_to(icon, name=nil, options=nil, html_options=nil, &block)
    link_to(options, html_options) do
      fa_icon("#{icon} 2x", title: name)
    end
  end

  def format_time(datetime)
    datetime.strftime('%k:%M:%S')
  end

  def format_date_time(datetime)
    datetime.strftime('%Y.%m.%d %k:%M:%S')
  end

  def format_currency(number)
    number_to_currency(number, separator: ',', delimiter: '`', precision: 0, unit: '$')
  end

  def format_number(number)
    number_with_delimiter(number, separator: ',', delimiter: '`', precision: 0)
  end

end
