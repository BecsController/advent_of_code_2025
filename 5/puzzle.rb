require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

fresh_count = 0

ingredients, list = elf_inputs.split("\n\n")
ingredient_ranges = ingredients.split("\n")

def check_range(range_string, ingredient_id)
  beg_range, end_range = range_string.split("-").map(&:to_i)
  (beg_range..end_range).include?(ingredient_id.to_i)
end


list.split("\n").each do |ingredient|
  fresh = false
  count = 0

  while fresh == false && count < ingredient_ranges.count
    ingredient_ranges.each do |range_string|
      in_range = check_range(range_string, ingredient)

      fresh = true if in_range
      count += 1
    end
  end

  fresh_count += 1 if fresh == true
end

puts "Solution One = #{fresh_count}"

# Solution part two

ranges = ingredient_ranges.map{ |range| b_range, e_range = range.split("-").map(&:to_i); (b_range..e_range) }.sort_by{ |range| range.first };

total_fresh_ingredients = 0

current_start = ranges[0].first
current_end = ranges[0].last

ranges.each_with_index do |range, i|
  if (current_start..current_end).overlap?(range)
    current_end = [range.last, current_end].max
  else
    total_fresh_ingredients += (current_start..current_end).size
    current_start = range.first
    current_end = range.last
  end
end

total_fresh_ingredients += (current_start..current_end).size

puts "Solution Two = #{total_fresh_ingredients}"



