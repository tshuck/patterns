require './runners/base_runner.rb'

class BounceRunner < BaseRunner
  def starting_positions
    @quarter_width = (@width / 4).to_i
    @three_quarter_width = (@width / 4 * 3).to_i

    outer_flakes + wall_flakes + inner_flakes
  end

  def outer_flakes
    [
      RainbowFlake.new(position: 0),
      RainbowFlake.new(position: @width - 1)
    ]
  end

  def wall_flakes
    [
      VerticalFlake.new(position: @quarter_width),
      VerticalFlake.new(position: @three_quarter_width)
    ]
  end

  def inner_flakes
    [
      Flake.new(position: @quarter_width + 2, color: :blue),
      Flake.new(position: @quarter_width + 6, color: :magenta),
      Flake.new(position: @three_quarter_width - 6, color: :red),
      Flake.new(position: @three_quarter_width - 2, color: :green)
    ]
  end

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
