require 'date'

puts 'Input your day:'
day = gets.chomp.to_i
puts 'Input your month:'
month = gets.chomp.to_i
puts 'Inputs your year:'
year = gets.chomp.to_i

your_date = Date.new(year, month, day)
year_first_date = Date.new(year, 1, 1)

puts (your_date - year_first_date + 1).to_i
