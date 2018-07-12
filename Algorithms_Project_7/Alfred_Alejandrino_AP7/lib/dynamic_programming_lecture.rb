class DynamicProgramming

    def initialize
        @blair_cache = { 1 => 1, 2 => 2}
        @froggy_cache = []
        @maze_cache = {}
    end

    def blair_nums(n)
        return @blair_cache[n] if @blair_cache[n]
        odd_number = 2 * (n - 1) - 1

        @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + odd_number

    end

    def frog_hops_bottom_up(n)

        frog_cache_builder(n)[n]
    end

    def frog_cache_builder

        ways_collection = [[[]], [[1]], [[1, 1], [2]]]
        return ways_collection if n < 3

        (3..n).each do |i|
            new_way_set = []

            (1..3).each do |first_step|
                ways_collection[i - first_step].each do |way|
                    new_way = [first_step]

                    way.each do |step|
                        new_way << step
                    end

                    new_way_set << new_way
                end
            end

            ways_collection << new_way_set
        end

        ways_collection
    end

    def frog_hops_top_down(n)
        frog_hops_top_down_helper(n)
    end

    def frog_hops_top_down_helper(n)
        return @froggy_cache[n] if @froggy_cache[n]
        new_way_set = []

        (1..3).each do |first_step|
            frog_hops_top_down_helper(n - first_step).each do |way|
                new_way = []

                way.each do |step|
                    new_way << step
                end

                new_way_set << new_way
            end
        end

        @froggy_cache[n] = new_way_set
    end

    def super_frog_hops(n, k)
        ways_collection = [[[]], [[1]]]
        return ways_collection[n] if n < 2

        (2..n).each do |i|
            new_way_set = []

            (1..k).each do |first_step|
                break if i - first_step < 0
                ways_collection[i - first_step].each do |way|
                    new_way = [first]

                    way.each do |step|
                        new_way << step
                    end

                    new_way_set << new_way
                end
            end

            ways_collection << new_way_set
        end

        ways_collection[n]
    end

    def knapsack(weights, values, capacity)
        return 0 if weights.length == 0 || capacity == 0

        solution_table = knapsack_table(weights,values,capactiy)
        solution_table[capacity][-1]

    end

    def solution_table(weights, values, capacity)
        solution_table = []

        (0..capacity).each do |i|
            solution_table[i] = []

            (0...weights.length).each do |j|
                if i == 0
                    solution_table[i][j] = 0
                elsif j == 0
                    solution_table[i][j] = weights[j] > i ? 0 : value[j]
                else
                    option1 = solution_table[i][j-1]
                    option2 = weights[j] > i ? 0 : solution_table[i - weights[j]] + values[j]
                
                    optimum = [option1, option2].max
                    solution_table[i][j] = optimum
                end
            end
        end

        solution_table
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