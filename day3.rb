#!/usr/bin/env ruby -w

def manhattan_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

def signal_delay(wires, ix, iy)
  x, y = 0, 0
  delay = 0

  wires.split(/,/).each do |path|
    case path
    when /R(\d+)/
      $1.to_i.times do |i|
        x += 1
        delay += 1
        return delay if ix == x && iy == y
      end
    when /L(\d+)/
      $1.to_i.times do |i|
        x -= 1
        delay += 1
        return delay if ix == x && iy == y
      end
    when /U(\d+)/
      $1.to_i.times do |i|
        y += 1
        delay += 1
        return delay if ix == x && iy == y
      end
    when /D(\d+)/
      $1.to_i.times do |i|
        y -= 1
        delay += 1
        return delay if ix == x && iy == y
      end
    end
  end
end

# wire1 = "R8,U5,L5,D3"
# wire2 = "U7,R6,D4,L4"

# wire1 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
# wire2 = "U62,R66,U55,R34,D71,R55,D58,R83"

# wire1 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
# wire2 = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"

wire1, wire2 = File.open(ARGV[0]).readlines
circuit = {}
x, y = 0, 0
circuit[[x, y]] = 1

wire1.split(/,/).each do |path|
  case path
  when /R(\d+)/
    $1.to_i.times do |i|
      x += 1
      circuit[[x, y]] = 1
    end
  when /L(\d+)/
    $1.to_i.times do |i|
      x -= 1
      circuit[[x, y]] = 1
    end
  when /U(\d+)/
    $1.to_i.times do |i|
      y += 1
      circuit[[x, y]] = 1
    end
  when /D(\d+)/
    $1.to_i.times do |i|
      y -= 1
      circuit[[x, y]] = 1
    end
  end
end

x, y = 0, 0

wire2.split(/,/).each do |path|
  case path
  when /R(\d+)/
    $1.to_i.times do |i|
      x += 1
      if circuit.key?([x, y]) && circuit[[x, y]] == 1
        circuit[[x, y]] = 2
      else
        circuit[[x, y]] = 0
      end
    end
  when /L(\d+)/
    $1.to_i.times do |i|
      x -= 1
      if circuit.key?([x, y]) && circuit[[x, y]] == 1
        circuit[[x, y]] = 2
      else
        circuit[[x, y]] = 0
      end
    end
  when /U(\d+)/
    $1.to_i.times do |i|
      y += 1
      if circuit.key?([x, y]) && circuit[[x, y]] == 1
        circuit[[x, y]] = 2
      else
        circuit[[x, y]] = 0
      end
    end
  when /D(\d+)/
    $1.to_i.times do |i|
      y -= 1
      if circuit.key?([x, y]) && circuit[[x, y]] == 1
        circuit[[x, y]] = 2
      else
        circuit[[x, y]] = 0
      end
    end
  end
end

intersections = circuit.select { |_, v| v == 2 }

# 1st puzzle
puts intersections.map { |(x, y), _| manhattan_distance(0, 0, x, y) }.min

# 2nd puzzle
puts intersections.map { |(x, y), _| signal_delay(wire1, x, y) + signal_delay(wire2, x, y) }.min
