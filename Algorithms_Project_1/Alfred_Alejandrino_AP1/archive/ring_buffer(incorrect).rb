require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @arr = []
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    return @arr[index]
  end

  # O(1)
  def []=(index, val)
    @arr[index] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    @arr.pop
  end

  # O(1) ammortized
  def push(val)
    resize! if length == capacity
    @arr.push(val)
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0
    @arr.shift
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity
    @arr.unshift(val)
  end

  def length
    @length
  end

  def capacity
    @capacity
  end

  def store
    
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    @capacity *= 2
  end
end
