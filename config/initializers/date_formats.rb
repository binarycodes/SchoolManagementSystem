# Time formater to display birthday
Date::DATE_FORMATS[:birthday] = lambda { |date| date.strftime("#{date.day.ordinalize} %B, %Y") }
