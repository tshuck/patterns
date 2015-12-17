require 'colorize'
require './flakes/flake.rb'
require './flakes/rainbow_flake.rb'
require './flakes/vertical_flake.rb'
require './flakes/random_direction_flake.rb'

class BaseRunner
  def initialize(options = {})
    @width = options[:width] || 80
    @flakes = starting_positions
  end

  def run
    while running?
      move_flakes
      enforce_bounds
      print_flakes
      pause
    end
  end

  def starting_positions
    [ Flake.new, Flake.new(position: @width - 1) ]
  end

  def running?
    true
  end

  def move_flakes
    @flakes.each { |flake| flake.continue }
  end

  def enforce_bounds
    @flakes.each do |flake|
      if flake.position < 0
        flake.position = 0
        flake.switch_direction
      elsif flake.position >= @width
        flake.position = @width - 1
        flake.switch_direction
      end
    end
  end

  def print_flakes
    puts generate_line.join
  end

  def generate_line
    line = Array.new(@width, ' ')
    @flakes.each do |flake|
      line[flake.position] = flake.to_print
    end
    line
  end

  def pause
    sleep(0.1)
  end
end
