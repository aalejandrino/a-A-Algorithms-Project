require_relative "heap"

class Array
  def heap_sort!
    # self.sort! #lol
 
    prc = Proc.new {|el1, el2| (el2 <=> el1)}
    arr_len = self.length

    (1...arr_len).each do |idx|
      BinaryMinHeap.heapify_up(self, idx, &prc)
    end

    self[0], self[-1] = self[-1], self[0]
  
    (arr_len-2).downto(0).each do |idx|
      BinaryMinHeap.heapify_down(self, 0, idx+1, &prc)
      self[0], self[idx] = self[idx], self[0]
      
    end

    return self

  end
end
