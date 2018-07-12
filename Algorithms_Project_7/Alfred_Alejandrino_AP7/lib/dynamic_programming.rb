require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [[1]],
                    2 => [[1, 1], [2]],
                    3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
                  }
    @super_frog_cache = { 1 => [[1]] }
    @maze_cache = {}
  end

  def blair_nums(n) # from top-down
    return @blair_cache[n] if @blair_cache[n]
    ans = blair_nums(n - 1) + blair_nums(n - 2) + ((n - 1)*2 - 1)
    @blair_cache[n] = ans

    return ans
  end

  # def blair_nums(n) # from bottom-up
  #   return @blair_cache[n] if @blair_cache[n]

  #   (3..n).each do |num|
  #     ans = blair_nums(num - 1) + blair_nums(num - 2) + ((num - 1)*2 - 1)
  #     @blair_cache[num] = ans
  #   end

  #   return @blair_cache[n]

  # end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    return @frog_cache[n] if @frog_cache[n]

    (4..n).each do |num_stairs|
      @frog_cache[num_stairs] = []

      (1..3).each do |diff|
        @frog_cache[num_stairs - diff].each {|arr| @frog_cache[num_stairs] << (arr + [diff])}
      end
      
    end
    
    @frog_cache[n]

  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)

  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    @frog_cache[n] = []

    (1..3).each do |diff|
      @frog_cache[n].concat(frog_hops_top_down_helper(n - diff).map {|arr| arr + [diff]})
    end

    @frog_cache[n]
  end

  def super_frog_hops(n, k)
    super_frog_hops_builder(n, k)
  end

  def super_frog_hops_builder(n, k)

    # builds on stair step #1 - from 2 to n
    (2..n).each do |num_stairs|
      @super_frog_cache[num_stairs] = [] # initializes the next number of stairs with empty array

      (1..k).each do |diff|
        next if num_stairs <= diff
        
        @super_frog_cache[num_stairs - diff].each do |arr| # iterates through the previous steps

          # pushes in new, modified sub_arrays depending on the previous steps and current difference
          # also checks for duplicates and maintains uniqueness
          @super_frog_cache[num_stairs] << (arr + [diff]) unless (@super_frog_cache[num_stairs].include?(arr + [diff])) 
        end  
      end

      # lastly, pushes in a new sub_array [num_stair] only if the frog can jump that many steps
      # also checks for duplicates and maintains uniqueness
      @super_frog_cache[num_stairs] << [num_stairs] unless (k < num_stairs || @super_frog_cache[num_stairs].include?([num_stairs]))

    end

    return @super_frog_cache[n]
  end

  def knapsack(weights, values, capacity)
    @knapsack = { 0 => Array.new(weights.length, 0) }
    knapsack_table(weights, values, capacity)
    # p @knapsack.sort_by {|k,v| k} #checks cache
    @knapsack[capacity].last
  end

  # Helper method for bottom-up implementation
  # you must select the optimum from between these two paradigms: use either the previous item solution at this capacity, or the previous item solution from a smaller bag plus this item's value.
  def knapsack_table(weights, values, capacity)
    return 0 if capacity <= 0 || weights.length == 0

    i = weights.length -   1

    @knapsack[capacity] = [] if @knapsack[capacity].nil?

    return @knapsack[capacity][i] if @knapsack[capacity][i]

    prev = knapsack_table(weights[0...i], values[0...i], capacity)
    other = knapsack_table(weights[0...i], values[0...i], capacity - weights[i]) + values[i]
    return prev if weights[i] > capacity
    choices = [prev, other]
    max = choices.max
    @knapsack[capacity][i] = max
    max
  end

  def maze_solver(maze, start_pos, end_pos)
      build_cache(start_pos)
      solve_maze(maze, start_pos, end_pos)
      find_path(end_pos)
  end

  private

  def solve_maze(maze, start_pos, end_pos)
      return true if start_pos == end_pos

      get_moves(maze, start_pos).each do |new_loc|
          unless @maze_cache.keys.include?(new_loc)
              @maze_cache[new_loc] = start_pos
              solve_maze(maze, new_loc, end_pos)
          end
      end
  end

  def build_cache(start_pos)
      @maze_cache[start_pos] = nil
  end

  def find_path(end_pos)
      path = []
      current = end_pos

      until current.nil?
          path.unshift(current)
          current = @maze_cache[current]
      end

      path
  end

  def get_moves(maze, from_pos)
      directions = [[0, 1], [1, 0], [-1, 0], [0, -1]]
      x, y = from_pos
      result = []

      directions.each do |dx, dy|
          new_loc = [x + dx, y + dy]
          result << new_loc if is_valid_pos?(maze, new_loc)
      end

      result
  end

  def is_valid_pos?(maze, pos)
      x, y = pos
      x >= 0 && y >= 0 && x < maze.length && y < maze.first.length && maze[x][y] != "X"
  end
end
