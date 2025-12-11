require "pry"

# Solution part one

elf_inputs_test = File.open("test_input.txt").read
elf_inputs = File.open("input.txt").read

inputs = elf_inputs.split("\n").map{|l| l.split(":")}

START = "you"; WAY_OUT = "out"

DICTIONARY = inputs.each_with_object({}) do |(key, output), hash|
  hash[key] = output.strip.split(" ")
end

@paths = {}

def find_paths(current_position, path_set = Set.new)
  return @paths[[current_position, path_set]] if @paths.key?([current_position, path_set])

  total = 0
  if current_position == WAY_OUT
    return 1
  end

  DICTIONARY[current_position].each do |next_step|
    unless path_set.include?(current_position)
      next_possible_set = path_set.dup.add(current_position)
      total += find_paths(next_step, next_possible_set)
    end
  end
  @paths[[current_position, path_set]] = total
  total
end

# puts "Solution One = #{find_paths(START)}"

# Solution part two
elf_inputs_test_two = File.open("test_input_two.txt").read
inputs_two = elf_inputs_test_two.split("\n").map{|l| l.split(":")}

START_TWO = "svr"; WAY_OUT_TWO = "out"

DICTIONARY_TWO = inputs.each_with_object({}) do |(key, output), hash|
  hash[key] = output.strip.split(" ")
end

@paths = {}

def find_paths_two(current_position, path_set = Set.new)
  cache_key = [current_position, path_set.to_a.sort.join(",")]
  return @paths[cache_key] if @paths.key?(cache_key)

  total = 0
  if current_position == WAY_OUT_TWO
    if path_set.include?("fft") && path_set.include?("dac")
      return 1 
    else
      return 0
    end
  end

  DICTIONARY_TWO[current_position].each do |next_step|
    unless path_set.include?(current_position)
      next_possible_set = path_set.dup.add(current_position)
      total += find_paths_two(next_step, next_possible_set)
    end
  end

  @paths[cache_key] = total
  total
end

puts "Solution Two = #{find_paths_two(START_TWO)}"

