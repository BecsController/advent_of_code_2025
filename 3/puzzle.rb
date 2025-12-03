require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

banks = elf_inputs.split("\n")

joltages = banks.map do |bank| 
  chars = bank.chars.map(&:to_i)
  max = chars.max

  if max == chars.last
    max = chars[0..-2].max
  end

  index_of_max = chars.index(max)
  rest_of_options = chars[index_of_max + 1..-1]
  next_highest = rest_of_options.max

  max.to_s.concat(next_highest.to_s).to_i
end

puts "Solution One = #{joltages.sum}"

# Solution part two

@banks_two = elf_inputs.split("\n")

def update_set(battery, chars)
  index_of_max = chars.index(battery)
  chars[index_of_max + 1..-1]
end

def get_joltages(number_of_batteries)
  joltages = []
  @banks_two.map do |bank|
    chars = bank.chars
    max = chars[0..-number_of_batteries].max
    set = [max]
    repetitions = number_of_batteries - 1
    chars = update_set(max, chars)

    repetitions.times do |i|
      number_of_remaining_batteries = number_of_batteries - set.count
      battery = i + 1 == repetitions ? chars.max : chars[0..-number_of_remaining_batteries].max
      set << battery
      chars = update_set(battery, chars)
    end

    joltages << set.join.to_i
  end

  joltages.sum
end
  
puts "Solution Two = #{get_joltages(12)}"


