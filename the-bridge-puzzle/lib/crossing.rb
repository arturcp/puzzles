class Crossing
  RIGHT = 'right'
  LEFT = 'left'

  attr_reader :time_to_cross, :log, :characters_on_the_left,
    :characters_on_the_right

  def initialize(characters_on_the_left, group_to_cross, characters_on_the_right, orientation = RIGHT)
    @characters_on_group = group_to_cross.to_a
    @characters_on_the_left = characters_on_the_left
    @characters_on_the_right = characters_on_the_right
    @time_to_cross = group_to_cross.time_to_cross
    @orientation = orientation
  end

  def make
    if @orientation == RIGHT
      @characters_on_the_left = @characters_on_the_left - @characters_on_group
      save_log
      @characters_on_the_right = @characters_on_the_right + @characters_on_group
    else
      @characters_on_the_right = @characters_on_the_right - @characters_on_group
      save_log
      @characters_on_the_left = @characters_on_the_left + @characters_on_group
    end

    self
  end

  private

  def save_log
    @log = @characters_on_the_left.empty? ? '[]' : @characters_on_the_left.map(&:name).join(', ')
    group_characters = @characters_on_group.map(&:name).join(', ')

    if @orientation == RIGHT
      @log += "   [#{group_characters.yellow}]=> "
    end

    @log += "..............#{@time_to_cross.to_s.rjust(2, ' ').red} ................ "

    if @orientation == LEFT
      @log += "   <=[#{group_characters.yellow}] "
    end

    @log += @characters_on_the_right.empty? ? '[]' : @characters_on_the_right.map(&:name).join(', ') || '[]'
  end
end
