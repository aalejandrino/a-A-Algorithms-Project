require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [[1]],
                    2 => [[1, 1], [2]],
                    3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
                  }
    @super_frog_cache = { 1 => [[1]] }
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
    return 0 if capacity == 0

    knapsack_table(weights, values, capacity)
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

    length = weights.length
    tables = [Array.new(length, 0)]

    (1..capacity).each do |cap|
      if weights.all? {|wt| wt > cap }
        tables << Array.new(length, 0)
      else
        sub_arr = []

        weights.each_with_index do |wt, idx|
          if wt > cap
            sub_arr << sub_arr.last || 0
          else
            ans = [sub_arr.last || 
              0, values[idx]].max
          
            sub_arr << ans
          end

        end

        tables << sub_arr
      end

    end
    
    tables.last.last
    
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
