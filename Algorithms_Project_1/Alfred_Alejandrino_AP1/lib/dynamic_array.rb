require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = @store.length
    @length = 0
    
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @length == 0 || index >= @length
    return @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    num = @store[length-1]
    @store[length - 1] = nil
    @length -= 1
    return num
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    num = @store[0]
    @store.shift_left
    @length -= 1
    return num
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @store.shift_right
    @store[0] = val
    @length += 1
  end

  def length
    @store.count
  end

  def store
    @store
  end

  def capacity
    @capacity
  end

  attr_accessor :capacity, :store
  protected
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    newStore = StaticArray.new(@capacity*2)

    (0..@capacity-1).each do |idx|
      newStore[idx] = @store[idx]
    end

    @store = newStore
    @capacity = @store.length
    
  end

end
