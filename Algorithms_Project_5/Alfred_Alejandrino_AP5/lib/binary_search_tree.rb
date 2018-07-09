# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require 'byebug'

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

  def depth(tree_node = @root, count = 0)

    height(tree_node) - 1
  end 

  def height(tree_node = @root)
    return 0 if tree_node.nil?

    leftHeight = height(tree_node.left)
    rightHeight = height(tree_node.right)

    return [leftHeight, rightHeight].max + 1
  end

  def check_if_bal(tree_node = @root)
    return 0 if tree_node.nil?

    leftHeight = check_if_bal(tree_node.left)
    return -1 if leftHeight == -1

    rightHeight = check_if_bal(tree_node.right)
    return -1 if rightHeight == -1

    diff = leftHeight - rightHeight
    if diff.abs > 1
      return -1
    else
      [leftHeight, rightHeight].max + 1
    end
  end

  def is_balanced?(tree_node = @root)
    check_if_bal(tree_node) == -1 ? false : true
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node == nil

    result = []

    result.concat in_order_traversal(tree_node.left)
    result << tree_node.value
    result.concat in_order_traversal(tree_node.right)

    result

  end



  private
  # optional helper methods go here:

end
