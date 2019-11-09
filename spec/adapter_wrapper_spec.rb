require_relative '../demo/book'

RSpec.describe Book do

  before(:each) do
    @book = Book.demo
  end

  it "adapter wrapper should apply origin instance's self-point" do

    expect(@book.adapter_wrapper.target).to eq(@book)

  end

  it "adapter wrapper's methods can use return inside" do

    expect(@book.adapter_wrapper.id).to eq(@book.id)

  end

end