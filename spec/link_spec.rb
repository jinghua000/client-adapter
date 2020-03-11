require_relative '../demo/book'

RSpec.describe ClientDataAdapter do

  before(:each) do
    @book = Book.demo
  end

  it "link one should call linked target's adapter method" do

    expect(@book.adapter(:book_shelf))
      .to eq(
            id: @book.id,
            title: @book.title,
            book_shelf: {
              id: @book.book_shelf.id,
              desc: @book.book_shelf.desc,
            }
          )

  end

  it "link one can pass arguments" do

    expect(@book.adapter(book_shelf: :other_desc))
      .to eq(
            id: @book.id,
            title: @book.title,
            book_shelf: {
              id: @book.book_shelf.id,
              desc: @book.book_shelf.desc,
              other_desc: @book.book_shelf.adapter_wrapper.other_desc,
            }
          )

  end

  it "link can be nested" do

    @book_shelf = @book.book_shelf
    @library = @book_shelf.library

    expect(@book.adapter(book_shelf: [:other_desc, library: :welcome]))
      .to eq(
            id: @book.id,
            title: @book.title,
            book_shelf: {
              id: @book_shelf.id,
              desc: @book_shelf.desc,
              other_desc: @book_shelf.adapter_wrapper.other_desc,
              library: {
                id: @library.id,
                size: @library.size,
                welcome: @library.adapter_wrapper.welcome,
              },
            }
          )
  end

  it "link many should call all linked targets's adapter method" do

    @categories = @book.categories
    expect(@book.adapter(:categories))
      .to eq(
            id: @book.id,
            title: @book.title,
            categories: [
              {
                id: @categories[0].id,
                cat: @categories[0].cat,
              },
              {
                id: @categories[1].id,
                cat: @categories[1].cat,
              },
            ]
          )

  end

  it "link many can pass arguments" do

    @categories = @book.categories
    expect(@book.adapter(categories: :summary))
      .to eq(
            id: @book.id,
            title: @book.title,
            categories: [
              {
                id: @categories[0].id,
                cat: @categories[0].cat,
                summary: @categories[0].summary,
              },
              {
                id: @categories[1].id,
                cat: @categories[1].cat,
                summary: @categories[1].summary,
              },
            ]
          )

  end

  it "if link one's target is nil, return nil" do
    expect(@book.adapter_wrapper.empty_book_shelf).to eq(nil)
    expect(@book.adapter(:empty_book_shelf))
      .to eq(
            id: @book.id,
            title: @book.title,
            empty_book_shelf: nil,
          )
  end

  it "if link many's target is nil, return []" do
    expect(@book.adapter_wrapper.empty_categories).to eq([])
    expect(@book.adapter(:empty_categories))
      .to eq(
            id: @book.id,
            title: @book.title,
            empty_categories: [],
          )
  end

end
