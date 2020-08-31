all_letters = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
vowel_hash = {}

vowels.each { |e| vowel_hash[e.to_sym] = all_letters.index(e) + 1 }

puts vowel_hash

