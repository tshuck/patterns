require './runners/base_runner.rb'
require './runners/rainbow_runner.rb'
require './runners/bounce_runner.rb'
require './runners/random_bounce_runner.rb'

# runner = BaseRunner.new
# runner = RainbowRunner.new
# runner = BounceRunner.new width: 60
runner = RandomBounceRunner.new width: 100
runner.run
