require_relative 'simulator.rb'

simulator = Simulator.instance

input = STDIN.gets
while input
  msg = simulator.run(input)
  puts msg if msg
  input = STDIN.gets
end
