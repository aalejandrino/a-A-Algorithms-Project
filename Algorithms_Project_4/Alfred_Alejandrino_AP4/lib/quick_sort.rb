require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    first = array[0]
    others = array[1..-1]

    left = others.select {|n| n < first}
    right = others.select {|n| n > first}

    QuickSort.sort1(left) + [first] + QuickSort.sort1(right)

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1

    prc ||= Proc.new{|x,y| x <=> y}
    
    idx = QuickSort.partition(array, start, length, &prc)
    
    QuickSort.sort2!(array, start, idx-start, &prc)
    QuickSort.sort2!(array, idx+1, length-idx-1, &prc)

  end

  def self.partition(array, start, length, &prc)
    # p "partition called"
    return if length <= 1
    prc ||= Proc.new{|x,y| x <=> y}

    barrier = start

    (start+1...start+length).each do |idx|
     
      num = prc.call(array[start], array[idx])
      # p "proc called"

      if num == 1
        barrier += 1
        array[barrier],  array[idx] = array[idx], array[barrier]
      end


    end

    array[start], array[barrier] = array[barrier], array[start]

    # p barrier
    return barrier #pivot index
  end

  
end
