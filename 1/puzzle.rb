require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read.split("\n")
elf_inputs = File.open("input.txt").read.split("\n")

dial_position = 50
number_of_zeros = 0
start_of_dial = 0
end_of_dial = 99
total_zero_clicks = 0

DIRECTION_KEY = {
  "L": "-",
  "R": "+"
}

elf_inputs.each do |rotation|
  direction, distance = rotation.split(/(\d+)/)
  operator = DIRECTION_KEY[direction.to_sym]
  distance = distance.to_i

  while distance > 0
    dial_position = eval(dial_position.to_s + operator + "1")

    if dial_position == 100
      dial_position = start_of_dial
      total_zero_clicks += 1
    elsif dial_position.negative?
      dial_position = end_of_dial
    elsif dial_position.zero?
      total_zero_clicks += 1
    end
    distance -= 1
  end

  number_of_zeros += 1 if dial_position.zero?
end

puts "Solution One = #{number_of_zeros}"
puts "Solution Two = #{total_zero_clicks}"