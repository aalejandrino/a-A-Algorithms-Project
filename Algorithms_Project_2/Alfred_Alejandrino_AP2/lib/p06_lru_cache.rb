require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      node = @map.get_node(key)
      # byebug
      update_node!(node)
      node.val
    else
      # byebug
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    new_node = @store.append(key, val)
    # byebug
    @map[key] = new_node

    eject! if count > @max
    val
  end

  def update_node!(node)
    # byebug
    if node
      @store.remove(node.key)
      @store.append(node.key, node.val)
    end
  end

  def eject!
    node = @store.first
    @store.remove(node.key)
    @map.delete(node.key)
  end
end
