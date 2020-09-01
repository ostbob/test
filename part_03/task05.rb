puts 'Input your day:'
day = gets.chomp.to_i
puts 'Input your month:'
month = gets.chomp.to_i
puts 'Inputs your year:'
year = gets.chomp.to_i


month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 400 == 0
  year_is_leap = true
elsif year % 100 == 0
  year_is_leap = false
elsif year % 4 == 0
  year_is_leap = true
else
  year_is_leap = false
end

if year_is_leap
  month_days[1] = 29
end

your_day_number = day

month_days[0...month-1].each do |days|
  your_day_number += days
end

puts your_day_number
