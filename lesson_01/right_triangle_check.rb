puts 'Give me first side of triangle:'
first_side = gets.chomp.to_f
puts 'Give me second side of triangle:'
second_side = gets.chomp.to_f
puts 'Give me third side of triangle:'
third_side = gets.chomp.to_f

first_catet, second_catet, max_side = [first_side, second_side, third_side].sort

if max_side**2 == first_catet **2 + second_catet**2
  puts 'Triangle is right'
else
  puts 'Triangle is not right'
end
