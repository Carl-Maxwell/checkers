require 'matrix'

class Array
  def to_vector()
    Vector[*self]
  end
end
