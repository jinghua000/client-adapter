require_relative '../lib/client-data-adapter'

RSpec.describe ClientDataAdapter do

  it "should return the version" do

    expect(ClientDataAdapter::VERSION)
      .to eq('0.1.3')

  end

end
