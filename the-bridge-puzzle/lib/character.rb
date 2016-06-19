class Character
  attr_reader :name, :time_to_cross

  def initialize(name, time_to_cross)
    @name = name
    @time_to_cross = time_to_cross
  end
end
