require "pry"
require "matrix"
# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

@grid = elf_inputs.split("\n").map{ |line| line.chars };

@paper_roll_accessible_count = 0
ADJACENT_POSITIONS = [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]

def is_on_edge?(x, y, change_x, change_y, grid)
  x.zero? && change_x.negative? || y.zero? && change_y.negative? || x == grid.length - 1 && change_x.positive? || y == grid.first.length - 1 && change_y.positive?
end

def check_surround(x, y, grid)
  set = []

  ADJACENT_POSITIONS.each do |coord|
    change_to_x, change_to_y = coord

    unless is_on_edge?(x, y, change_to_x, change_to_y, grid)
      new_x = x + change_to_x
      new_y = y + change_to_y

      set << grid[new_x][new_y]
    end
  end

  set
end

def check_grid(grid)
  coords_to_change = []

  grid.each_with_index do |line, x|
    line.each_with_index do |coord, y|
      if coord == "@"
        surrounding_nodes = check_surround(x, y, grid)

        if surrounding_nodes.count("@") < 4
          @paper_roll_accessible_count += 1 
          coords_to_change << [x, y]
        end
      end
    end
  end

  coords_to_change
end

check_grid(@grid)

puts "Solution One = #{@paper_roll_accessible_count}"

# Solution part two

@paper_roll_accessible_count = 0

def make_new_grid(coords, grid)
  coords.each do |coord|
    x, y = coord
    grid[x][y] = "X"
  end
  grid
end

grid = elf_inputs.split("\n").map{ |line| line.chars };

result_of_checking_grid = check_grid(grid)

while result_of_checking_grid.any?
  grid = make_new_grid(result_of_checking_grid, grid)
  result_of_checking_grid = check_grid(grid)
end

puts "Solution Two = #{@paper_roll_accessible_count}"



