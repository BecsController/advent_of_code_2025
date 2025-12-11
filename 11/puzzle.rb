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
inputs_two = elf_inputs.split("\n").map{|l| l.split(":")}

START_TWO = "svr"; WAY_OUT_TWO = "out"

DICTIONARY_TWO = inputs_two.each_with_object({}) do |(key, output), hash|
  hash[key] = output.strip.split(" ")
end

# create a compact bit-index for each node so visited sets become integers (bitmasks)
nodes = (DICTIONARY_TWO.keys | DICTIONARY_TWO.values.flatten).uniq
@index_map = {}
nodes.each_with_index { |n, i| @index_map[n] = i }

# precompute required-bit masks (nil-safe)
@fft_bit = @index_map.key?("fft") ? (1 << @index_map["fft"]) : 0
@dac_bit = @index_map.key?("dac") ? (1 << @index_map["dac"]) : 0

# memo: per-position hash of mask -> count (avoids expensive composite keys)
@paths = Hash.new { |h,k| h[k] = {} }

def find_paths_two(current_position, mask = 0)
  return @paths[current_position][mask] if @paths[current_position].key?(mask)

  if current_position == WAY_OUT_TWO
    return ((mask & @fft_bit) != 0 && (mask & @dac_bit) != 0) ? 1 : 0
  end

  total = 0
  idx = @index_map[current_position]
  visited = idx && ((mask >> idx) & 1) != 0

  # if not visited, mark visited and explore children
  unless visited
    new_mask = idx ? (mask | (1 << idx)) : mask
    (DICTIONARY_TWO[current_position] || []).each do |next_step|
      total += find_paths_two(next_step, new_mask)
    end
  end

  @paths[current_position][mask] = total
  total
end

puts "Solution Two = #{find_paths_two(START_TWO)}"



