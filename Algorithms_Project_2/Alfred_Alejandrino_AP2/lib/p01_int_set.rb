class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if (num < 0 || num > @max)
  end

  def validate!(num) 
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  
  end

  def insert(num)
    self[num] << num 
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].any? {|n| n == num}
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    self[num] << num
    @count += 1
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].any? {|n| n == num}
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    newStore = Array.new(@num_buckets) {Array.new}

    @store.each do |bucket|
      bucket.each {|el| newStore[el % @num_buckets] << el}
    end

    @store = newStore

  end
end
