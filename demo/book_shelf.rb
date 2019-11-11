require_relative 'library'

class BookShelf

  include ClientDataAdapter

  define_adapter do

    link_one :library

    adapter do
      {
        id: id,
        desc: desc,
      }
    end

    with :other_desc do
      'other desc'
    end

  end

  attr_accessor :id, :desc, :library_id

  def initialize(**opt)

    self.id = opt[:id]
    self.desc = opt[:desc]
    self.library_id = opt[:library_id]

  end

  def self.demo
    new(
      id: 1,
      desc: 'my book shelf',
      library_id: 1,
    )
  end

  def library
    Library.demo
  end

end