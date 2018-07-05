require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
  end

  def count
    @store.length
  end

  def extract
    extract_num = @store.min
    extract_i = nil
    
    @store.each_with_index do |el, i|
      extract_i = i if el == extract_num
    end

    @store[extract_i], @store[-1] = @store[-1], @store[extract_i]
    # byebug
    result = @store.pop

    BinaryMinHeap.heapify_down(@store, 0, @store.length)

    # p @store
    return result
    
  end

  def peek
    @store.last
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length-1)
  end

  public
  def self.child_indices(len, parent_index)
    child_index1 = parent_index*2 + 1
    child_index2 = parent_index*2 + 2
    result = [child_index1 < len ? child_index1 : nil, child_index2 < len ? child_index2 : nil]
    result.delete(nil)

    return result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if (child_index < 1)
    return (child_index - 1) / 2 
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = prc || Proc.new {|el1, el2| el1 <=> el2}
    
    (0...len).each do |idx|
      child_idx = self.child_indices(len, idx)
      next if child_idx.empty?
      current_el = array[idx]
      el1 = array[child_idx[0]]
      el2 = array[child_idx[1]] if child_idx[1]

      if ((!!el1 && !el2) || prc.call(el1,el2) == -1) && (prc.call(current_el, el1) == 1)
        array[idx], array[child_idx[0]] = el1, current_el

      elsif (prc.call(el1, el2) == 1) && (prc.call(current_el, el2) == 1)
        array[idx], array[child_idx[1]] = el2, current_el

      end
    end

    return array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc || Proc.new {|el1, el2| el1 <=> el2}
    current_idx = child_idx
    
    indices = [child_idx]
    until current_idx == 0
      indices.push(self.parent_index(current_idx))
      # byebug
      current_idx = parent_index(current_idx)
    end
    
    indices.each_with_index do |el, i|
      next if i == indices.length - 1
      # byebug
      array[indices[i]], array[indices[i+1]] = array[indices[i+1]], array[indices[i]] if prc.call(array[indices[i]], array[indices[i+1]]) == -1
    end

    return array
  end

end

