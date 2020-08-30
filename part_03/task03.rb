first_number, second_number = [0, 1]

fibonacci = [first_number, second_number]

while second_number <= 100
  first_number, second_number = second_number, first_number + second_number
  if second_number < 100
    fibonacci.append(second_number)
  end
end

puts fibonacci
