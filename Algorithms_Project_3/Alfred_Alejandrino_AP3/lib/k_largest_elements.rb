require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
    # prc = Proc.new {|el1, el2| el2 <=> el1}

    # bmh = BinaryMinHeap.new(&prc)
    # result = []

    # array.each do |el|
    #     bmh.push(el)
    # end

    # k.times{ result << bmh.extract }

    # return result
    
    ## above solution uses BinaryMinHeap and extracts max
    ## below solution uses HeapSort!

    return array.heap_sort!.drop(array.length - k)
end
