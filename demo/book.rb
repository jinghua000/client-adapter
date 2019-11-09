require_relative '../lib/client-data-adapter'
require_relative 'book_shelf'

class Book

  include ClientDataAdapter

  define_adapter do

    adapter do
      {
        id: id,
        title: title,
      }
    end

    with :full_title do
      "<#{title}>"
    end

    with :my_awesome_title do
      "my_awesome_title"
    end

    with :pass_sth do |*args|
      args
    end

    with :id do
      return id if true
      raise 'CODE WILL NOT REACH HERE.'
    end

  end

  attr_accessor :id, :title, :book_shelf_id

  def initialize(**opt)

    self.id = opt[:id]
    self.title = opt[:title]
    self.book_shelf_id = opt[:book_shelf_id]

  end

  def self.demo
    new(
      id: 1,
      title: 'My Book',
      book_shelf_id: 1,
    )
  end

  def my_title
    'my title'
  end

  def my_awesome_title
    'no no no'
  end

  def sub_title(sub)
    "#{title}-#{sub}"
  end

  def book_shelf
    BookShelf.demo
  end

end