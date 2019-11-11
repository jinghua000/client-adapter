require_relative '../demo/book'

RSpec.describe Book do

  before(:each) do
    @book = Book.demo
  end

  it "adapter method return adapter wrapper's __adapter__" do

    expect(@book.adapter).to eq(id: @book.id, title: @book.title)
    expect(@book.adapter).to eq(@book.adapter_wrapper.__adapter__)

  end

  it "adapter can contain `with` method's returns" do

    expect(@book.adapter_wrapper.respond_to? :full_title).to eq(true)
    expect(@book.adapter(:full_title))
      .to eq(
            id: @book.id,
            title: @book.title,
            full_title: @book.adapter_wrapper.full_title
          )

  end

  it "adapter can contain origin class instance method" do

    expect(@book.adapter_wrapper.respond_to? :my_title).to eq(false)
    expect(@book.adapter(:my_title))
      .to eq(
            id: @book.id,
            title: @book.title,
            my_title: @book.my_title
          )

  end

  it "methods inside adapter wrapper will override method outside" do

    expect(@book.my_awesome_title).not_to eq(@book.adapter_wrapper.my_awesome_title)
    expect(@book.adapter(:my_awesome_title))
      .to eq(
            id: @book.id,
            title: @book.title,
            my_awesome_title: @book.adapter_wrapper.my_awesome_title
          )

  end

  it "adapter can pass arguments in `with` method block" do

    expect(@book.adapter(pass1: [:a, :b, :c], pass2: [:x, :y, :z]))
      .to eq(
            id: @book.id,
            title: @book.title,
            pass1: @book.adapter_wrapper.pass1(*[:a, :b, :c]),
            pass2: @book.adapter_wrapper.pass2(*[:x, :y, :z]),
          )

  end

  it "adapter can pass arguments with origin class instance methods" do

    expect(@book.adapter(sub_title: 'yes'))
      .to eq(
            id: @book.id,
            title: @book.title,
            sub_title: @book.sub_title('yes')
          )

  end

end