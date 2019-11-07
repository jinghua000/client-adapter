class City

  attr_accessor :id, :name

  def initialize(**opt)

    self.id = opt[:id]
    self.name = opt[:name]

  end

  def status
    'very good'
  end

end