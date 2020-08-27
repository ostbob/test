print "Give me a, b, c coefficients for quadratic equation please.\n"
print "Give me a:\n"
a = Integer(gets.chomp)
print "Give me b:\n"
b = Integer(gets.chomp)
print "Give me c:\n"
c = Integer(gets.chomp)

D = b**2 - 4*a*c

if D < 0
  print "Корней нет\n"
elsif D == 0
  print "Дискриминант: #{D}\n"
  x = -b/2*a
  print "Корень: #{x}\n"
elsif D > 0
  x1 = (-b + Math.sqrt(D))/(2*a)
  x2 = (-b - Math.sqrt(D))/(2*a)
  print "Дискриминант: #{D}\n"
  print "Корень x1: #{x1}\n"
  print "Корень x2: #{x2}\n"
end
