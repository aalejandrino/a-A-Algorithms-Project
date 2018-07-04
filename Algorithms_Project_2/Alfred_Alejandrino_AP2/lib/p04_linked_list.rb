require 'byebug'

class Node

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next, @next.prev = @next, @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new(nil, 'head')
    @tail = Node.new(nil, 'tail')

    @nodes = []

    @head.next, @tail.prev = @tail, @head
    @count = 0

  end

  def [](i)
    @nodes.each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    return nil if @count == 0
    @head.next
  end

  def last
    return nil if @count == 0
    @tail.prev
  end

  def empty?
    return true if @count == 0
    return false
  end

  def get(key)
    # @nodes.each {|node| return node.val if node.key == key}
    if @count != 0
      current_node = first
      # byebug
      until current_node.next == nil
        return current_node.val if current_node.key == key
        current_node = current_node.next
      end
    end
    
    nil
  end

  def get_node(key)
    # @nodes.each {|node| return node.val if node.key == key}
    if @count != 0
      current_node = first

      until current_node.next == nil
        return current_node if current_node.key == key
        current_node = current_node.next
      end
    end
    
    nil
  end

  def include?(key)
    @nodes.any? {|node| node.key == key}
  end

  def append(key, val)
    newNode = Node.new(key, val)
    @nodes << newNode
    if (@count == 0)
      newNode.next, newNode.prev = @tail, @head
      @head.next = newNode
      @tail.prev = newNode
    else
      newNode.next, newNode.prev = @tail, @tail.prev
      @tail.prev.next, @tail.prev = newNode, newNode
      # newNode.next, newNode.prev = @tail, @tail.prev
      # @tail.prev = newNode
    end
    @count += 1
  end

  def update(key, val)
    node = get_node(key)
    node.nil? ? nil : node.val = val
  end

  def remove(key)
    current_node = first if @count != 0

    # @count.times {
    #   current_node.remove if current_node.key == key
    #   current_node = current_node.next
    # }
    until current_node.next == nil
      current_node.remove if current_node.key == key
      current_node = current_node.next
    end
    @count -= 1
  end

  def each(&block)
    nodes = []
    current_node = first
    # byebug
    until current_node == nil || current_node.next == nil
      # nodes << current_node
      block.call(current_node)
      current_node = current_node.next
    end

    # byebug
    
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
