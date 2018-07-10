require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
    sorted = []
    top = Queue.new

    vertices.each do |vertex|
        if vertex.in_edges.empty?
            top.enq(vertex)
        end
    end

    until top.empty?
        current_node = top.pop
        sorted << current_node
        # byebug
        current_node.out_edges.each do |edge|
            next_node = edge.to_vertex
            edge.destroy!
            
            if next_node.in_edges.empty?
                top.enq(next_node)
            end

        end

    end
    
    # p sorted.map {|node| node.value}
    sorted.length == vertices.length ? sorted : []
end
