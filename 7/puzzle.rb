require "pry"
require "set"
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

@starting_points_two = [[0, first_row.index("S")]]
@paths = []

def next_steps(x, y)
  new_position = @grid[y + 1][x]
  next_steps = []

  case new_position
  when "^"
    next_steps << [y + 1, x - 1] unless @grid[y + 1][x - 1].nil?
    next_steps << [y + 1, x + 1 ] unless @grid[y + 1][x + 1].nil?
  when "."
    next_steps << [y + 1, x]
  else
    puts "Something went wrong"
  end

  next_steps
end

def find_a_path(coords, next_point, path_so_far, path_set = Set.new)
  y, x = coords

  if y == @grid.count - 1
    path_so_far.push(coords)
    @paths << path_so_far
  else
    next_steps(x, y).each do |next_step|
      unless path_set.include?(coords)
        next_possible_path = path_so_far.clone.push(coords)
        next_possible_set = path_set.dup.add(coords)
        find_a_path(next_step, next_point, next_possible_path, next_possible_set)
      end
    end
  end
end

find_a_path([0, first_row.index("S")], [1, first_row.index("S")], [], Set.new)

puts "Solution Two = #{@paths.count}"



