class Table

	attr_accessor :position

  #set position
  def place(x, y)
    self.position = { x: x.to_i, y: y.to_i } if valid_coordinates?(x, y)
  end

  def been_placed?
    !self.position.nil?
  end

  private

  def valid_coordinates?(x, y)
    valid_position?(x) && valid_position?(y)
  end

  def valid_position? s
  	s.to_i.between?(0,4)
  end
end
