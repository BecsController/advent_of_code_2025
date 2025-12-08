require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

coords = elf_inputs.split("\n").map{ |l| l.split(",").map(&:to_i)};
@create_library = {}

def find_distance(first, second)
  # Euclidean distance
  x1, y1, z1 = first
  x2, y2, z2 = second
  Math.sqrt((x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2)
end

coords.each do |coord|
   coords.reject{ |c| c == coord }.each do |c|
   key_title = [c, coord].sort
   @create_library[key_title] = find_distance(coord, c)
  end
end

@closest_set_list = @create_library.sort_by{ |k, v| v }.map{|a| a.first.map(&:join)}.first(1000)
@connection_count = 0

def try_to_connect(current_set)
  @closest_set_list.reject{ |a| a == current_set}.each_with_index do |merged_set, index|

    if (Set.new(current_set) & Set.new(merged_set)).any?
      combination = (Set.new(merged_set) + Set.new(current_set)).to_a
      @closest_set_list.delete(merged_set)
      @closest_set_list.delete(current_set)
      @closest_set_list << combination
    end
  end
end

def merge_sets
  @closest_set_list.each do |shortest|
    try_to_connect(shortest)
  end
end

def any_stragglers?
  @closest_set_list.any? do |arr|
    rest_of_junctions = @closest_set_list.reject{ |a| a == arr }
    rest_of_junctions.any? do |array| 
      array.any? { |str| arr.include?(str) }
    end
  end
end

while any_stragglers?
  merge_sets
end

first, second, third = @closest_set_list.map(&:count).max(3)

puts "Solution One = #{first * second * third}"

# Solution part two

all_distances = @create_library.sort_by{ |k, v| v }.map{|a| a.first.map(&:join)}


puts "Solution Two = #{}"



