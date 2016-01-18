class BaseRunner
  attr_accessor :width, :flakes

  def initialize(flakes: [], switch_direction_on_collision: -> {}, distribute_flakes: -> {}, width: 80)
    @switch_direction_on_collision = switch_direction_on_collision
    @flakes = flakes
    @width = width

    distribute_flakes.call(self)
  end

  def run
    while running?
      move_flakes
      print_flakes
      pause
    end
  end

  def running?
    true
  end

  def move_flakes
    @flakes.each do |flake|
      # Direction switching could belong to the flakes themselves,
      # although we'd have to give them knowledge of the rest of the set of
      # flakes.
      @switch_direction_on_collision.call(self, flake)
      flake.continue
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
