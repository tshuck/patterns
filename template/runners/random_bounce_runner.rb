require './runners/base_runner.rb'

class RandomBounceRunner < BaseRunner
  def starting_positions
    tenth_width = (@width / 10).to_i
    total_dots = [Random.rand(tenth_width), 1].max

    dot_space_proportion = (@width / total_dots)

    (0...total_dots).map do |dot_idx|
      starting_position = dot_idx + Random.rand(dot_space_proportion)

      random_flake starting_position
    end
  end

  def random_flake(position)
    klass = [Flake, RainbowFlake, VerticalFlake, RandomDirectionFlake].sample

    klass.new position: position, color: random_color, direction: random_direction
  end

  # NOTE:  in a more modular pattern, this should be mixed in
  # to DRY up random_bounce_runner#random_color and rainbow_flake#to_print
  def random_color
    String
      .colors
      .reject { |color| color == :default }
      .sample
  end

  def random_direction
    [Flake::LEFT, Flake::RIGHT].sample
  end

  # NOTE:  in a more modular pattern, this should somehow get mixed in
  # to DRY up bounce_runner#enforce_bounds and random_bounce_runner#enforce_bounds
  def enforce_bounds
    sorted_flakes = @flakes.sort_by { |flake| flake.position }

    sorted_flakes.each_with_index do |flake, idx|
      break if idx == sorted_flakes.size - 1
      next_flake = sorted_flakes[idx + 1]

      if collides_exact?(flake, next_flake)
        flake.switch_direction
        next_flake.switch_direction
      end
    end

    super
  end

  def collides_exact?(flake, other_flake)
    flake.position == other_flake.position
  end
end
