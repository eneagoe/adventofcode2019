#!/usr/bin/env ruby -w

start = 264360
stop = 746325

# 1st puzzle
puts (start..stop).count { |i| i.to_s =~ /^(?=\d{6}$)0*1*2*3*4*5*6*7*8*9*$/ && i.to_s =~ /(\d)\1/ }

# 2nd puzzle
puts (start..stop).count { |i| i.to_s =~ /^(?=\d{6}$)0*1*2*3*4*5*6*7*8*9*$/ && i.to_s.scan(/((\d)\2+)/).map { |m| m[0].size }.include?(2) }
