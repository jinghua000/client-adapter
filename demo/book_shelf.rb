class BookShelf

  attr_accessor :id, :desc, :library_id

  def initialize(**opt)

    self.id = opt[:id]
    self.desc = opt[:desc]
    self.library_id = opt[:library_id]

  end

end