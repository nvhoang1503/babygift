require 'spec_helper'

describe "redeems/new" do
  before(:each) do
    assign(:redeem, stub_model(Redeem,
      :transaction_code => "MyString",
      :string => "MyString"
    ).as_new_record)
  end

  it "renders new redeem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => redeems_path, :method => "post" do
      assert_select "input#redeem_transaction_code", :name => "redeem[transaction_code]"
      assert_select "input#redeem_string", :name => "redeem[string]"
    end
  end
end
