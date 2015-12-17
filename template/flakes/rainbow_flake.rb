require './flakes/flake.rb'

class RainbowFlake < Flake
  # NOTE:  in a more modular pattern, this should be mixed in
  # to DRY up random_bounce_runner#random_color and rainbow_flake#to_print
  def to_print
    @color = String
             .colors
             .reject { |color| color == :default }
             .sample
    super
  end
end
