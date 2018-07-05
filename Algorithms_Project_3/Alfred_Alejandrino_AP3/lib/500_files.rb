def five_hundred_files(arr_of_arrs)
    prc = Proc.new {|el1, el2| el1[0] <=> el2[0]}

    heap = BinaryMinHeap.new(&prc)

    result = []

    arr_of_arrs.length.times do |i|
        heap.push([arr_of_arrs][i][0], i, 0)
    end

    while heap.count > 0
        min = heap.extract
        result << min[0]

        next_arr_i = min[1]
        next_idx = min[2] + 1
        next_el = arr_of_arrs[next_arr_i][next_idx]

        heap.push([next_el, next_arr_i, next_idx]) if next_el

    end

    result
end

def almost_sorted

end