require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
    prc = Proc.new {|el1, el2| el2 <=> el1}

    bmh = BinaryMinHeap.new(&prc)
    result = []

    array.each do |el|
        bmh.push(el)
    end

    k.times{ result << bmh.extract }

    return result
    
    ## above solution uses BinaryMinHeap and extracts max <<
    ## below solution uses HeapSort! <<

    # return array.heap_sort!.drop(array.length - k)


    ## below solution uses a backwards heapsort!
    # prc = Proc.new {|el1, el2| (el1 <=> el2)}
    # arr_len = array.length

    # (1...arr_len).each do |idx|
    #   BinaryMinHeap.heapify_up(array, idx, &prc)
    # end

    # array[0], array[-1] = array[-1], array[0]
  
    # (arr_len-2).downto(0).each do |idx|
    #   BinaryMinHeap.heapify_down(array, 0, idx+1, &prc)
    #   array[0], array[idx] = array[idx], array[0]
      
    # end

    # # p array
    # return array.take(k)
end
