require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @arr = []
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if (length == 0 && index || index >= length)
    return @arr[index]
  end

  # O(1)
  def []=(index, value)
    @arr[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if (length == 0)
    @arr.pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity
    @arr.push(val)
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if (length == 0)
    @arr.shift
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity
    @arr.unshift(val)
  end

  def length
    return @arr.length
  end

  def capacity
    @capacity
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
  end
end
