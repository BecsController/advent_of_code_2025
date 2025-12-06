require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

grid = elf_inputs_test.split("\n").map{|line| line.split(" ") }

answers = grid.transpose.map do |vertical_line|
  operator = vertical_line.last
  vertical_line.slice(1...-1).reduce(vertical_line.first) do |sum, n| 
    eval(sum + operator + n).to_s
  end
end

puts "Solution One = #{answers.map(&:to_i).sum}"

# Solution part two

total = 0
answers = []


grid_two = elf_inputs.split("\n").map{|line| line.split("") }
new_set = ""

grid_two.transpose.reverse.each do |line|
  if ["+", "*"].include?(line.last)
    new_set.concat("#{line[0...-1].join.strip}\n")
    new_set.concat("#{line.last}")
  elsif line.join.strip.empty?
    new_set.concat("\n\n")
  else
    new_set.concat("#{line.join.strip}\n")
  end
end

last_grid = new_set.split("\n\n").map{ |l| l.split("\n") }

answers = last_grid.map do |equation|
  operator = equation.last

  answer = equation.slice(1...-1).reduce(equation.first) do |sum, n| 
    eval(sum + operator + n).to_s
  end
end

puts "Solution Two = #{answers.map(&:to_i).sum}"



