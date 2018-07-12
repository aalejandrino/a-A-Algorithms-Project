require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [[1]],
                    2 => [[1, 1], [2]],
                    3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
                  }
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
    @frog_cache[n] = frog_cache_builder(n)

    @frog_cache[n]

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
    return @frog_cache[1] if n == 1

    frog_hops_top_down_helper(n - 1)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
