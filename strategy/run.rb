require './base_runner'
require './flake'

# Using Procs here as an exercise - this file is way too big and these should
# be static methods on a module or something, e.g., 'FlakeColor::Rainbow'

# Colors for flakes
rainbow_color = lambda do |flake|
  Flake::COLORS.sample
end

random_color = lambda do |flake|
  flake.cached_color ||= Flake::COLORS.sample
end

# Shapes for flakes
rainbow_shape = lambda do |flake|
  Flake::SHAPES.sample
end

# Flake setup
flakes = [
  Flake.new(shape: rainbow_shape),
  Flake.new(color: rainbow_color),
  Flake.new(shape: rainbow_shape, color: rainbow_color)
]

# Collision detection for the runner
bounce_on_walls = lambda do |runner, flake|
  return flake.turn_right if flake.position == 0
  flake.turn_left if flake.position == runner.width
end

bounce_on_flakes = lambda do |runner, _flake|
  sorted_flakes = runner.flakes.sort_by { |flake| flake.position }

  # Iterate flakes from left to right, skipping the last
  sorted_flakes.each_with_index do |flake, idx|
    break if idx == sorted_flakes.size - 1
    next_flake = sorted_flakes[idx + 1]

    if flake.position == next_flake.position
      flake.turn_left
      next_flake.turn_right
    end
  end
end

bounce_on_walls_and_flakes = lambda do |runner, flake|
  bounce_on_flakes.call(runner, flake)
  bounce_on_walls.call(runner, flake)
end

# Initial flake distribution for the runner
even_distribution = lambda do |runner|
  increment = (runner.width / flakes.size).to_i
  runner.flakes.each_with_index do |flake, idx|
    flake.position = idx * increment
  end
end

all_left = lambda do |runner|
  runner.flakes.each_with_index do |flake, idx|
    flake.position = idx
  end
end

# Pick a collision and distribution function and go
runner = BaseRunner.new(flakes: flakes, switch_direction_on_collision: bounce_on_walls_and_flakes, distribute_flakes: even_distribution)
runner.run
