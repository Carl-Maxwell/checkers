
class EmptySquare
  @@instances = nil

  def self.sentinel
    @@instance ||= self.class.new
  end
end
