item_hash = {}

loop do
  puts 'input your item:'
  item = gets.chomp

  break if item == 'стоп'

  puts 'input item price:'
  item_price = gets.chomp.to_f
  puts 'input item quantity:'
  item_quantity = gets.chomp.to_f

  if not item_hash.key?(item.to_sym)
    item_hash[item.to_sym] = {}
  end

    item_hash[item.to_sym][item_price] = item_quantity
end

total = 0

item_hash.each do |key, value|
  item_amount = 0
  value.each do |k, v|
    item_amount += k*v
  end
  puts "Item: #{key}: #{item_amount}"
  total += item_amount
end

puts "Total: #{total}"
