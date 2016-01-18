require 'colorize'

class Flake
  attr_accessor :position, :direction, :color, :shape, :flakes

  RIGHT = 'right'
  LEFT = 'left'

  def initialize(options = {})
    @position = options[:position] || 0
    @direction = options[:direction] || Flake::RIGHT
    @color = options[:color] || 'white'
    @shape = options[:shape] || '*'
  end

  def to_print
    @shape.send(@color)
  end

  def continue
    return right if @direction == Flake::RIGHT
    left
  end

  def turn_right
    @direction = Flake::RIGHT
  end

  def turn_left
    @direction = Flake::LEFT
  end

  def left
    @position -= 1
  end

  def right
    @position += 1
  end
end
