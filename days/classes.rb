class DayNine
  def initialize()
    @head_position = [0,0]
    @tail_position = [0,0]

    @turn_map = {}
  end

  def play!
    mark_tail_position!

    read_file.each do |line|
      direction = line.split(' ').first
      steps = line.split(' ').last

      steps.times do
        move_head!(direction)
      end

      mark_tail_position!
    end

    puts "The answer to the puzzle is #{@turn_map.keys.length}"
  end

  private

  def move_head!(direction)
    movement = case direction
    when 'R'
      [1,0]
    when 'U'
      [0,1]
    when 'L'
      [-1, 0]
    when 'D'
      [0,-1]
               end

    @head_position = [@head_position.first + movement.first, @head_position.last + movement.last]
  end

  def mark_tail_position!
    @turn_map[@tail_position.join(',')] = @tail_position
  end

  def tail_must_move?
    # [0,0] [0,1] NOPE
    # [0,0] [1,0] NOPE
    # [0,0] [0,2] YES
    # [0,0] [2,0] YES
    # [0,0] [1,1] NOPE
    #
    # [-1,-1] [1,1] NOPE

    return true if Math.abs(@head_position.first - @tail_position.first) > 1
    return true if Math.abs(@head_position.last - @tail_position.last) > 1

    false
  end
end