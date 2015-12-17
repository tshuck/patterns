require './runners/base_runner.rb'

class RainbowRunner < BaseRunner
  def starting_positions
    [
      RainbowFlake.new,
      RainbowFlake.new(position: (@width / 4).to_i),
      RainbowFlake.new(position: (@width / 2).to_i),
      RainbowFlake.new(position: (@width / 4 * 3).to_i)
    ]
  end
end
