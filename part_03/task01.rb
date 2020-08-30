require 'date'

month_names = Date::MONTHNAMES[1..13]
month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if Date.gregorian_leap?(Time.now.year)
  month_days[1] = 29
end

month_hash = Hash[month_names.map(&:to_sym).zip(month_days)]

month_30_days = month_hash.select {|k,v| v == 30}
month_30_days.each {|k,v| puts k}
