require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return true if get(key)
    return false
  end

  def set(key, val)
    resize! if count == num_buckets
    if bucket(key).get(key)

      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end

  end

  def get(key)
    # byebug
    bucket(key).get(key)
  end

  def get_node(key)
    bucket(key).get_node(key)
  end

  def delete(key)
    bucket(key).remove(key) if include?(key)
    @count -= 1
  end

  def each(&block)
    # nodes = []

    @store.each do |linkedlist|
      next if linkedlist.empty?
      # byebug
      linkedlist.each {|node| block.call(node.key, node.val) }

    end

  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!

    more_buckets = num_buckets * 2
    newStore = Array.new(more_buckets) { LinkedList.new }
    @store.each do |linkedlist|
      next if linkedlist.empty?

      linkedlist.each {|node| newStore[node.key.to_s.hash % (more_buckets)].append(node.key, node.val)}
    end

    @store = newStore

  end

  def bucket(key)
    @store[key.to_s.hash % num_buckets]
  end
end
