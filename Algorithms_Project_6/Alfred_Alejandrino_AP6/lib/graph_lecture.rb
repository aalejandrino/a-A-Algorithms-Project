class Vertex
    attr_reader :value, :in_edges, :out_edges

    def initialize(value)
        @value, @in_edges, @out_edges = value, [], []
    end
    
end


class Edge
    attr_reader :from_vertex, :to_vertex, :cost

    def initialize(from_vertex, to_vertex, cost = 1)
        @from_vertex = from_vertex
        @to_vertex = to_vertex
        @cost = cost

        @from_vertex.out_edges << self
        @to_vertex.in_edges << self
    end

    def destroy
        @from_vertex.out_edges.delete(self)
        @to_vertex.in_edges.delete(self)
        @from_vertex = nil
        @to_vertex = nil
    end
end

# Khan's Algorithm (using in_edge_count)
def topological_sort(vertices)
    queue = []
    order = []
    in_edge_count = {}

    vertices.each do |vertex|
        in_edge_count[vertex] = vertex.in_edges.count
        queue << vertex if vertex.in_edges.empty?
    end

    until queue.empty?
        current = queeue.shift
        order << current

        current.out_edges.each do |edge|
            to_vert = edge.to_vertex
            in_edge_count[to_vert] -= 1
            queue << to_vert if in_edge_count[to_vert] == 0
        end

    end

    order.length == vertices.length ? order : []
end

# Khan's Algorithm (destroy edges)
def topological_sort(vertices)
    queue = []
    order = []

    vertices.each do |vertex|
        queue << vertex if vertex.in_edges.empty?
    end

    until queue.empty?
        current = queue.shift
        order << current

        current.out_edges.dup.each do |edge|
            to_vert = edge.to_vertex
            queue << to_vert if to_vert.in_edges.count <= 1
            edge.destroy!
        end
    end

    order.length == vertices.length ? order : []
end

require 'set'
# Tarjan's Algorithm (without cycle catching)
def topological_sort(vertices)
    order = []
    explored = Set.new

    vertices.each do |vertex|
        dfs!(order, explored, vertex) unless explored.include?(vertex)
    end

    order
end

def dfs!(order, explored, vertex)
    explored.add(vertex)

    vertex.out_edges.each do |edge|
        to_vertex = edge.to_vertex
        dfs!(order, explored, to_vertex) unless explored.include?(vertex)
    end

    order.unshift(vertex)
end

# Tarjan's Algorithm (with cycle catching)
def topological_sort(vertices)
    order = []
    explored = Set.new
    temp = Set.new
    cycle = false

    vertices.each do |vertex|
        cycle = dfs!(order, explored, vertex) unless explored.include?(vertex)
        return [] if cycle
    end

    order
end

def dfs!(order, explored, vertex, temp, cycle)
    return true if temp.includes?(vertex)
    temp.add(vertex)
    
    vertex.out_edges.each do |edge|
        to_vertex = edge.to_vertex
        dfs!(order, explored, to_vertex) unless explored.include?(to_vertex)
        return true if cycle
    end
    
    explored.add(vertex)
    temp.delete(vertex)
    order.unshift(vertex)
    false
end




require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
    max = 0
    independent = []
    vertices = {}

    arr.each do |tuple|
        vertices[tuple[0]] = Vertex.new(vertices[tuple[0]]) unless vertices[tuple[0]]
        vertices[tuple[1]] = Vertex.new(vertices[tuple[1]]) unless vertices[tuple[1]]
        Edge.new(vertices[tuple[1]], vertices[tuple[0]])
    end

    max = tuple.max if typle.max > max

    (1..max).each do |i|
        independent << i unless vertices[i]
    end

    independent + topological_sort(vertices.values).map {|v| v.value}
end