# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'topological_sort'

def install_order(arr)
    max_id = arr.map{|s_arr| s_arr.first}.max

    packages = (1..max_id).map {|val| Vertex.new(val)}

    arr.each do |package_id, dependency|
        Edge.new(packages[dependency - 1], packages[package_id - 1])
    end

    # ============================================================================
    # p packages.map {|package| package.value}
    # p packages.map {|package| package.in_edges.map{|edge| edge.from_vertex.value}}
    # p packages.map {|package| package.out_edges.map{|edge| edge.to_vertex.value}}
    #
    # ** to test out vertices and edges **
    # =============================================================================

    return topological_sort(packages).map {|package| package.value}
end
