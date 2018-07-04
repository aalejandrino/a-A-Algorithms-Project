require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].any? {|el| el == key}
  end

  def remove(key)
    self[key].delete(key) if include?(key)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    newStore = Array.new(@num_buckets) {Array.new}
    
    @store.each do |bucket|
      bucket.each {|el| newStore[el.hash % @num_buckets] << el}
    end

    @store = newStore
  end
end
