require 'spec_helper'

describe "redeems/show" do
  before(:each) do
    @redeem = assign(:redeem, stub_model(Redeem,
      :transaction_code => "Transaction Code",
      :string => "String"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Transaction Code/)
    rendered.should match(/String/)
  end
end
