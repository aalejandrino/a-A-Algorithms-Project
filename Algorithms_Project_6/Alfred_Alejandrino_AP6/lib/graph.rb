class Vertex
  attr_accessor :value, :in_edges, :out_edges

  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end

  def add_in_edge(edge)
    @in_edges << edge
  end

  def add_out_edge(edge)
    @out_edges << edge
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @from_vertex.add_out_edge(self)

    @to_vertex = to_vertex
    @to_vertex.add_in_edge(self)

    @cost = cost
  end

  def destroy!
    @from_vertex.out_edges.delete(self)
    self.from_vertex = nil

    @to_vertex.in_edges.delete(self)
    self.to_vertex = nil

  end
end
