require_relative '../demo/book'

RSpec.describe Book do

  before(:each) do
    @book = Book.demo
  end

  it "adapter method return adapter wrapper's __adapter__" do

    expect(@book.adapter).to eq(id: 1, title: 'My Book')
    expect(@book.adapter).to eq(@book.adapter_wrapper.__adapter__)

  end

  it "adapter can contain `with` method's returns" do

    expect(@book.adapter_wrapper.respond_to? :full_title).to eq(true)
    expect(@book.adapter(:full_title))
      .to eq(
            id: 1,
            title: 'My Book',
            full_title: @book.adapter_wrapper.full_title
          )

  end

  it "adapter can contain origin class instance method" do

    expect(@book.adapter_wrapper.respond_to? :my_title).to eq(false)
    expect(@book.adapter(:my_title))
      .to eq(
            id: 1,
            title: 'My Book',
            my_title: @book.my_title
          )

  end

  it "methods inside adapter wrapper will override method outside" do

    expect(@book.my_awesome_title).not_to eq(@book.adapter_wrapper.my_awesome_title)
    expect(@book.adapter(:my_awesome_title))
      .to eq(
            id: 1,
            title: 'My Book',
            my_awesome_title: @book.adapter_wrapper.my_awesome_title
          )

  end

  it "adapter can pass arguments in `with` method block" do

    expect(@book.adapter(pass_sth: [:a, :b, :c]))
      .to eq(
            id: 1,
            title: 'My Book',
            pass_sth: @book.adapter_wrapper.pass_sth(*[:a, :b, :c])
          )

  end

  it "adapter can pass arguments with origin class instance methods" do

    expect(@book.adapter(sub_title: 'yes'))
      .to eq(
            id: 1,
            title: 'My Book',
            sub_title: @book.sub_title('yes')
          )

  end

end