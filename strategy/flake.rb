require 'colorize'

class Flake
  attr_accessor :position, :direction, :cached_color

  RIGHT = 'right'
  LEFT = 'left'
  SHAPES = ['*', '$', '@', '&']
  COLORS = [ :black, :red, :green, :yellow, :blue, :magenta, :cyan, :white,
    :light_black, :light_red, :light_green, :light_yellow, :light_blue,
    :light_magenta, :light_cyan, :light_white
  ] # Colorize gem

  def initialize(position: 0, direction: Flake::RIGHT, shape: lambda {|_flake| Flake::SHAPES.first }, color: lambda {|_flake| Flake::COLORS.first })
    @position = position
    @direction = direction
    @shape = shape
    @color = color
  end

  def to_print
    color = @color.call(self)

    @shape
      .call(self)
      .send color
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
