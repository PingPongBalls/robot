class Robot

  attr_accessor :orientation

  #setter method
  def face_to new_orient
    self.orientation = new_orient if valid_orientation?(new_orient)
  end

  def turn direction
    self.orientation = if direction == :left
      { east: :north, south: :east, west: :south, north: :west }[self.orientation]
    else
      { east: :south, south: :west, west: :north, north: :east }[self.orientation]
    end
  end

  def move_forward
    {east: [x:1, y:0], south: [x:0 , y:-1], west: [x:-1, y:0], north: [x:0, y:1]}[self.orientation]
  end

  private
    def valid_orientation?(new_orient)
      [:east, :south, :west, :north].include?(new_orient)
    end
end
