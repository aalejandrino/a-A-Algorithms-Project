# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

require_relative 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
    @count = 0
  end

  def insert(value)
    newNode = BSTNode.new(value)

    if @root == nil
      @root = newNode
    else
      @root.set(newNode)
    end

    @count += 1
  end

  def find(value, tree_node = @root)
    tree_node.find(value)
  end

  def delete(value)
    node_to_del = find(value)
    if (node_to_del.no_children? && node_to_del.no_parent?) #this is the root node
      @root = nil 
    elsif (node_to_del.no_children?) #has a parent node therefore, not the root node
      node_to_del.parent.left, node_to_del.parent.right = nil, nil
      node_to_del.parent = nil
    elsif (node_to_del.one_child?)
      parent = node_to_del.parent
      parent.left = nil if value < parent.value
      parent.right = nil if value > parent.value

      parent.set(node_to_del.left || node_to_del.right)
    else
      parent = node_to_del.parent
      max_node = maximum(node_to_del.left)
      delete(max_node.value)

      parent.left = nil if value < parent.value
      parent.right = nil if value > parent.value

      parent.set(max_node)
    end

    @count -= 1
    
  end

  # helper method   for #delete:
  def maximum(tree_node = @root)
    curr_node = tree_node
    curr_node = curr_node.right until curr_node.right == nil

    return curr_node
  end

  def depth(tree_node = @root)
    Math.log2(@count).ceil
  end 

  def is_balanced?(tree_node = @root)

  end

  def in_order_traversal(tree_node = @root, arr = [])
    
  end



  private
  # optional helper methods go here:

end
