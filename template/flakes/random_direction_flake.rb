require './flakes/flake.rb'

class RandomDirectionFlake < Flake
  def continue
    switch_direction if Random.rand(10) < 3
    super
  end
end
