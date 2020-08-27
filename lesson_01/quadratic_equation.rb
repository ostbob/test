puts 'Give me a, b, c coefficients for quadratic equation please.'
puts 'Give me a:'
a = gets.chomp.to_f
puts 'Give me b:'
b = gets.chomp.to_f
puts 'Give me c:'
c = gets.chomp.to_f

D = b**2 - 4*a*c

if D < 0
  puts 'Корней нет'
elsif D == 0
  puts "Дискриминант: #{D}"
  x = -b/(2*a)
  puts "Корень: #{x}"
elsif D > 0
  sqrt_of_D = Math.sqrt(D)
  x1 = (-b + sqrt_of_D)/(2*a)
  x2 = (-b - sqrt_of_D)/(2*a)
  puts "Дискриминант: #{D}"
  puts "Корень x1: #{x1}"
  puts "Корень x2: #{x2}"
end
