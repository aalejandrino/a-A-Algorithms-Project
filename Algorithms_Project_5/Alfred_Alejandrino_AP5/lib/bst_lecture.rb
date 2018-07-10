class BSTNode
    attr_reader :value
    attr_accessor :left, :right

    def initialize(value)
        @value = value
        @left, @right = nil, nil
    end
end

class BinarySearchTree
    attr_accessor :root

    def initialize
        @root = nil
    end

    def insert(value)
        @root = insert_into_tree(@root, value)
    end

    def find(value, tree_node = @root)
        return nil if tree_node.nil?
        return tree_node if value == tree_node.value

        if value < tree_node.value
            find(value, tree_node.left)
        else
            find(value, tree_node.right)
        end
    end

    def delete
        @root = remove_from_tree(@root, value)
    end

    def maximum(tree_node = @root)
        return nil if @root.nil?
        
        if tree_node.right
            max_node = maximum(tree_node.right)
        else
            max_node = tree_node
        end

        max_node
    end

    def depth(tree_node = @root)
        return -1 if tree_node.nil?

        left_depth = depth(tree_node.left)
        right_depth = depth(tree_node.right)

        [left_depth, right_depth].max + 1
    end

    def is_balanced?(tree_node = @root)
        return true if tree_node.nil?

        left_depth = depth(tree_node.left)
        right_depth = depth(tree_node.right)

        (left_depth - right_depth).abs < 2 && is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
    end

    def in_order_traversal(tree_node = @root, arr = [])
        in_order_traversal(tree_node.left, arr) if tree_node.left
        arr.push(tree_node.value)
        in_order_traversal(tree_node.right, arr) if tree_node.right
    end


    private

    def insert_into_tree(tree_node, value)
        return BSTNode.new(value) if tree_node.nil?

        if value <= tree_node.value
            tree_node.left = insert_into_tree(tree_node.left, value)
        else
            tree_node.right = insert_into_tree(tree_node.right, value)
        end

        tree_node
    end

    def remove_from_tree(tree_node, value)
        if value == tree_node.value
            tree_node = remove(tree_node)
        elsif value <= tree_node.value
            tree_node.left = remove_from_tree(tree_node.left, value)
        else
            tree_node.right = remove_from_tree(tree_node.right, value)
        end
    end

    def remove(node)
        if node.left.nil? && node.right.nil?
            node = nil
        elsif node.left && node.right.nil?
            node = node.left
        elsif node.left.nil? && node.right
            node = node.right
        else
            node = promote_parent(node)
        end
    end

    def promote_parent(node)
        replacement_node = maximum(node.left)

        if replacement_node.left
            direct_child = promote_child(node.left)
        end

        replacement_node.left = direct_child ? direct_child : node.left
        replacement_node.right = node.right
        replacement_node
    end

    def promote_child(node)
        if node.right
            parent = node
            child = node.right

            while child.right
                parent = parent.right
                child = child.right
            end

            parent.right = child.left
            nil
        else
            node.left
        end
    end
end

# =========
def kth_largest(tree_node, k)
    kth_node = { count: 0, correct_node: nil }
    reverse_inorder(tree_node, kth_node, k)[:correct_node]
end

def reverse_inorder(tree_node, kth_node, k)
    if tree_node && kth_node[:count] < k
        kth_node = reverse_inorder(tree_node.right, kth_node, k)
        if kth_node[:count] < k
            k
end

#Trevor will slack out

def lowest_common_ancestor(tree_node = root, node_1, node_2)
    if tree_node.value > node_1.value && tree_node.value > node_2.value
        lowest_common_ancestor(tree_node.left)
    elsif tree_node.value < node_1.value && tree_node.value < node_2.value
        lowest_common_ancestor(tree_node.right)
    else
        return tree_node
    end
end