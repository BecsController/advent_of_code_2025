require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

ids = elf_inputs.split(",")
ranges = ids.map {|ids| first, last = ids.split("-"); first.to_i..last.to_i}

@invalid_ids = []

def drop_leading_zeros(set)
  return set if set.nil?

  set.first == "0" ? set[1..-1] : set
end

def check_each_next(num)
  chars = num.to_s.chars
  result = (0..4).map do |i|
    if chars.count > i
      chunk = drop_leading_zeros(chars.slice(0..i))
      rest = chars.slice(i+1..-1)

      chunk == rest
    end
  end

  @invalid_ids << num if result.any?(true)
end

ranges.each do |range|
  range.each { |num| check_each_next(num) }
end

puts "Solution One = #{@invalid_ids.sum}"

# Solution part two

@invalid_ids_two = []

def check_til_end(i, num)
  num.each_slice(i).to_a
end

def check_array(array)
  array.each_with_index.map do |a, i|
    if i == (array.length - 1)
      true
    else
      a == array[i + 1]
    end
  end
end

def chunk_numbers(num)
  chars = num.to_s.chars
  half = (chars.length / 2) 

  possibilities = (1..half).map do |i|
    chars.each_slice(i).to_a
  end

  result = possibilities.map do |poss|
    check_array(poss)
  end

  @invalid_ids_two << num if result.any? { |arr| arr.all?(true) }
end

ranges.each do |range|
  range.each { |num| chunk_numbers(num) }
end

puts "Solution Two = #{@invalid_ids_two.sum}"



