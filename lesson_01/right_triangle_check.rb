print "Give me first side of triangle:\n"
first_side = Integer(gets.chomp)
print "Give me second side of triangle:\n"
second_side = Integer(gets.chomp)
print "Give me third side of triangle:\n"
third_side = Integer(gets.chomp)

if first_side >= second_side && first_side >= third_side
  max_side = first_side
  first_catet = second_side
  second_catet = third_side
elsif second_side >= first_side && second_side >= third_side
  max_side = second_side
  first_catet = first_side
  second_catet = third_side
else
  max_side = third_side
  first_catet = first_side
  second_catet = second_side
end

if max_side**2 == first_catet **2 + second_catet**2
  print "Triangle is right\n"
else
  print "Triangle is not right\n"
end
