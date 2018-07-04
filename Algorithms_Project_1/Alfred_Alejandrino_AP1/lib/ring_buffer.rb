require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = @store.length
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    num = @store[@start_idx + length - 1]
    @store[@start_idx + length - 1] = nil
    @length -= 1
    return num
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[length + @start_idx] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0
    num = @store[start_idx]
    @store[start_idx] = nil
    @start_idx += 1
    @length -= 1
    return num
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @store[start_idx-1] = val
    @start_idx -= 1
    @length += 1
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
    newArr = StaticArray.new(@capacity*2)
    @capacity = newArr.length
    
    (start_idx...(start_idx+length)).each do |idx|
      newArr[idx-start_idx] = @store[idx]
    end

    @store = newArr
    @start_idx = 0
  end
end
