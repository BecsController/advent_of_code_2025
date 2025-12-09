require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read
red_tiles = elf_inputs.split("\n").map{ |c| c.split(",").map(&:to_i) }

# max_x = red_tiles.max_by(&:first).first + 1
# max_y = red_tiles.max_by(&:last).last + 1
# @grid = []

# max_y.times do 
#   @grid << Array.new(max_x, ".")
# end

# Put red tiles on grid
@shape_sizes = []

def find_rectangle(coord_one, coord_two)
  distance_between_x = (coord_one.first - coord_two.first).abs + 1
  distance_between_y = (coord_one.last - coord_two.last).abs + 1

  @shape_sizes << distance_between_x * distance_between_y
end

red_tiles.each do |coord|
  all_others = red_tiles.reject {|t| t == coord }
  all_others.each do |second_coord|
    find_rectangle(coord, second_coord)
  end
end

puts "Solution One = #{@shape_sizes.max}"

# Solution part two

puts "Solution Two = #{}"



