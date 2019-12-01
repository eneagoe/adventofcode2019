#!/usr/bin/env ruby -w

fuel = 0
total_fuel = 0

File.open(ARGV[0]).each do |m|
  m = m.to_i
  required_fuel = m.to_i / 3 - 2
  fuel += required_fuel
  while required_fuel > 0
    total_fuel += required_fuel
    required_fuel = required_fuel / 3 - 2
  end
end

# 1st puzzle
puts fuel

# 2nd puzzle
puts total_fuel
