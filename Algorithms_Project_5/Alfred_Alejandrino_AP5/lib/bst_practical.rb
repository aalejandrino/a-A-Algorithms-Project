
def kth_largest(tree_node, k)
    traverse = in_order_node_traversal(tree_node)
    traverse[traverse.length - k]
end

def in_order_node_traversal(tree_node = @root, arr = [])
    return [] if tree_node == nil

    result = []

    result.concat in_order_node_traversal(tree_node.left)
    result << tree_node
    result.concat in_order_node_traversal(tree_node.right)

    result

end