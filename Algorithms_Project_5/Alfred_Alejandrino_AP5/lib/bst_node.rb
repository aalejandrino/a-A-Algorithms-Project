class BSTNode
  attr_accessor :value, :left, :right, :parent

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

  def set(node)

    if (node.value < @value)
      !!@left ? @left.set(node) : (@left = node; node.parent = self)
    elsif (@value < node.value)
      !!@right ? @right.set(node) : (@right = node; node.parent = self)
    end

    # node.parent = self
  end

  def find(val)
    return self if val == self.value

    if !!@left && val < @value
      @left.find(val)

    elsif !!@right && @value < val
      @right.find(val)

    else
      return nil

    end

  end

  def no_parent?
    if (parent == nil)
      return true
    else
      return false
    end
  end

    def no_children?
    if (left == nil && right == nil)
      return true
    else
      return false
    end
  end

  def one_child?
    if ((left != nil && right == nil) || 
        (right != nil && left == nil))
      return true
    else
      return false
    end
  end




end
