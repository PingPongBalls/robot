require 'singleton'

require_relative 'table.rb'
require_relative 'robot.rb'

class Simulator

  include Singleton

  attr_accessor :table, :robot
  
  def initialize
    @table ||= Table.new
    @robot ||= Robot.new
  end

  def run(command_line)
    return if command_line.strip.empty?
    
    command_array = command_line.split(/\s+/)
    command, params = command_array.first, command_array.last

    case command
    when 'PLACE'
      place(params)
    when 'MOVE'
      move
    when 'LEFT'
      turn :left
    when 'RIGHT'
      turn :right
    when 'REPORT'
      report
    else
      "Command not found"
    end
  end

  private
    def place(params)
      error_msg = 'PLACE with invalid arguments. Please check and try again.'
      begin
        params = params.split(/,/)
        x = params[0]
        y = params[1]
        orientation = params[2].downcase.to_sym

        error_msg unless is_int?(x) && is_int?(y) && @robot.face_to(orientation) && @table.place(x.to_i, y.to_i)
      rescue
        error_msg
      end
    end

    def move
      return unless @table.been_placed? && @robot.orientation

      distance = @robot.move_forward.first
      'Robot will fall off from table. Ignoring move command.' unless @table.place(@table.position[:x] + distance[:x], @table.position[:y] + distance[:y])
    end

    def turn(direction)
      return 'Please place the robot before turning.' unless @table.been_placed?

      direction == :left ? @robot.turn(:left) : @robot.turn(:right)

      report
    end

    def report
      return 'Please place a robot.' unless @table.been_placed?
      "#{@table.position[:x]},#{@table.position[:y]},#{@robot.orientation.to_s.upcase}"
    end

    def is_int? s
      /\A[-+]?\d+\z/ === s
    end
end