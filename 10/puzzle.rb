require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

manual = elf_inputs.split("\n")
light_regexp = /\[(.*?)\]/
wiring_regexp = /[\d+,?\d?]+/

def toggle(char)
  char == "." ? "#" : "."
end

def turn_on_lights?(light_diagram, combination)
  new_diagram = Array.new(light_diagram.count, ".")

  combination.flatten.each do |combo|
    current = new_diagram[combo.to_i]
    new_char = toggle(current)
    new_diagram[combo.to_i] = new_char
  end

  new_diagram == light_diagram
end

combo_count = manual.map do |instruction|
  light_diagram = instruction.scan(light_regexp).first.first.chars
  button_wiring = instruction.scan(wiring_regexp).map{ |w| w.scan(wiring_regexp) }[0...-1].map { |a| a.first.split(",")}

  starting_combination = 0
  lights_on = false

  while lights_on == false
    starting_combination += 1
    all_combinations = button_wiring.combination(starting_combination).to_a
    lights_on = all_combinations.any? { |combo| turn_on_lights?(light_diagram, combo) }
  end

  starting_combination
end

puts "Solution One = #{combo_count.sum}"

# Solution part two

def correct_joltage_level?(joltage_levels, combination)
  counters = Array.new(joltage_levels.length, 0)

  combination.flatten.each do |combo|
    counters[combo.to_i] += 1
  end

  counters.map(&:to_s) == joltage_levels
end

combo_count_two = manual.map do |instruction|
  wiring_and_joltage = instruction.scan(wiring_regexp).map{ |w| w.scan(wiring_regexp) }
  button_wiring = wiring_and_joltage[0...-1].map { |a| a.first.split(",")}
  joltage = wiring_and_joltage.last.first.split(",")
  starting_combination = joltage.max.to_i - 1
  correct_joltage = false
  
  while correct_joltage == false
    starting_combination += 1
    correct_joltage = button_wiring.repeated_combination(starting_combination).any? { |combo| correct_joltage_level?(joltage, combo) }
    puts "#{starting_combination}, #{joltage}"
  end

  starting_combination
end

puts "Solution Two = #{combo_count_two.sum}"



