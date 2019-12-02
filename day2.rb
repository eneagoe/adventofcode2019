#!/usr/bin/env ruby -w


def run_program(input:, noun: 12, verb: 2)
  memory = input.dup
  memory[1] = noun
  memory[2] = verb

  pc = 0
  while true
    code = memory[pc]
    case code
    when 1
      a, b = memory[pc + 1], memory[pc + 2]
      stored_at = memory[pc + 3]
      memory[stored_at] = memory[a] + memory[b]
    when 2
      a, b = memory[pc + 1], memory[pc + 2]
      stored_at = memory[pc + 3]
      memory[stored_at] = memory[a] * memory[b]
    when 99
      return memory[0]
    else
      raise 'Unknown opcode'
    end
    pc += 4
  end
end

input = File.open(ARGV[0]).read.split(/,/).map(&:to_i)

# 1st puzzle
puts run_program(input: input)

# 2nd puzzle
(0..99).each do |noun|
  (0..99).each do |verb|
    output = run_program(input: input, noun: noun, verb: verb)
    if output == 19690720
      puts 100 * noun + verb
      exit
    end
  end
end
