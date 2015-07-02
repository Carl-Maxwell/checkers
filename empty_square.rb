class EmptySquare
  def self.sentinel
    @@instance ||= EmptySquare.new()
  end

  def to_s
    "  "
  end
end
