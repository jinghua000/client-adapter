class Category

  include ClientDataAdapter

  define_adapter do

    adapter do
      {
        id: id,
        cat: cat,
      }
    end

  end

  attr_accessor :id, :cat

  def initialize(**opt)

    self.id = opt[:id]
    self.cat = opt[:cat]

  end

  def summary
    'summary'
  end

end