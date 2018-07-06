  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}

    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    child_val, parent_val = array[child_idx], array[parent_idx]
    if prc.call(child_val, parent_val) >= 0
        return array
    else
        array[child_idx], array[parent_idx] = parent_val, child_val
        heapify_up(array, child_idx - 1, &prc)
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}

    parent_el = array[parent_idx]
    left_idx, right_idx = self.child_indices(len, parent_idx)
    children = []
    children << array[left_idx] if left_idx
    children << array[right_idx] if right_idx

    return array if children.all? {|child| prc.call(parent_el, child) <= 0}

    swap_idx = nil

    if children.length == 1
        swap_idx = left_idx
    else
        swap_idx = (prc.call(children.first, children.second) <= 0 ? left_idx : right_idx)
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]

    self.heapify_down(array, swap_idx, len, &prc)
  end

  class Array

  def heap_sort!

    2.upto(count).each do |heap_sz|
        BinaryMinHeap.heapify_up(self, heap_sz - 1 ,heap_sz)
    end

    count,downto(2).each do |heap_sz|
        BinaryMinHeap.heapify_down(self, 0, heap_sz - 1)
    end

  end

end


def k_largest_elements(array, k)
    result = BinaryMinHeap.new

    k.times do
        result.push(array.pop)
    end
    
    until array.empty?
        result.push(array.pop)
        result.extract
    end

    result.store
end

def almost_sorted(arr, k)
    heap = BinaryMinHeap.new

    (k + 1).times do
        heap.push(arr.shift)
    end

    while heap.count > 0
        print heap.extract
        heap.push(arr.shift) if arr[0]
    end
end

require_relative 'heap'

def almost_sorted(arr, k)
  heap = BinaryMinHeap.new
  # If k = 2, the first output element must be
  # within the first 3 numbers, so we build a heap of 3
  (k + 1).times do
    heap.push(arr.shift)
  end

  # Accounts for when the array runs out but we still have
  # numbers in our heap
  while heap.count > 0
    print heap.extract
    heap.push(arr.shift) if arr[0]
  end
end