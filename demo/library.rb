class Library

  attr_accessor :id, :size, :city_id

  def initialize(**opt)

    self.id = opt[:id]
    self.size = opt[:size]
    self.city_id = opt[:city_id]

  end

end