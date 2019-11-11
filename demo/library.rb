class Library

  include ClientDataAdapter

  define_adapter do

    adapter do
      {
        id: id,
        size: size,
      }
    end

    with :welcome do
      'welcome'
    end

  end

  attr_accessor :id, :size, :city_id

  def initialize(**opt)

    self.id = opt[:id]
    self.size = opt[:size]

  end

  def self.demo
    new(
      id: 1,
      size: 'small'
    )
  end

end