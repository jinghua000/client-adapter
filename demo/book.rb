require_relative '../lib/client-data-adapter'
require_relative 'book_shelf'

class Book

  attr_accessor :id, :title, :book_shelf_id

  def initialize(**opt)

    self.id = opt[:id]
    self.title = opt[:title]
    self.book_shelf_id = opt[:book_shelf_id]

  end

  def full_title
    "<#{title}>"
  end

  def book_shelf
    BookShelf.new(
      id: 1,
      desc: 'my book shelf',
      library_id: 1,
    )
  end

end