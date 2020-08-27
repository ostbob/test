print "What is your name ?\n"
name = gets.chomp
print "What is your height?\n"
height = Integer(gets.chomp)

ideal_weight = (height - 110) * 1.15

if ideal_weight < 0
  print "Ваш вес уже оптимальный"
else
  print "#{name}, your ideal weight is #{ideal_weight}\n"
end
