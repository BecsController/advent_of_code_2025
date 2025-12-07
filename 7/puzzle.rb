require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

@grid = elf_inputs.split("\n").map{ |l| l.chars }
@split_junctions = []

first_row = @grid.first
@starting_points = [[0, first_row.index("S")]]

def on_edge?(x)
  x == 0 || x == @grid.count - 1
end

def look_down(x, y)
  return [nil, nil] if @grid[y + 1].nil?

  new_position = @grid[y + 1][x]

  case new_position
  when "^"
    @starting_points << [y + 1, x - 1] unless @grid[y + 1][x - 1].nil?
    @starting_points << [y + 1, x + 1 ] unless @grid[y + 1][x + 1].nil?
    @split_junctions << [y + 1, x] unless @split_junctions.include?([y + 1, x])
    [nil, nil]
  when "."
    [y + 1, x]
  else
    puts "Something went wrong"
  end
end

def follow_path(starting_point)
  y, x = starting_point

  while y != nil
    y, x = look_down(x, y)
  end
end

while @starting_points.any?
  starting_point = @starting_points.first
  follow_path(starting_point)
  @starting_points.delete(starting_point)
end

puts "Solution One = #{@split_junctions.count}"

# Solution part two


puts "Solution Two = #{}"



