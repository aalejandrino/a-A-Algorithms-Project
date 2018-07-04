# This class just dumbs down a regular Array to be statically sized.
require 'byebug'

class StaticArray
  def initialize(length)
    @store = Array.new(length)
    @length = length
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    return @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  def length
    @length
  end

  def count
    @store.count {|el| el != nil}
  end

  def delete(value)
    deleted = false

    @store.each_with_index do |el, idx|
      deleted = true if el == value

      if (deleted)
        if (idx == @store.length-1)
          @store[idx] = nil
          next
        end

        @store[idx] = @store[idx+1]
      end

    end

    p @store
  end

  def shift_right
    new_arr = [nil]

    @store.each_with_index do |el, idx|
      next if idx == @store.length - 1
      new_arr << el
    end

    # new_arr << nil until new_arr.length == length

    @store = new_arr

  end

  def shift_left
    @store.each_with_index do |el, idx|
      @store[idx] = @store[idx+1]
    end
  end

  protected
  attr_accessor :store
end
