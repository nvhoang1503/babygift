require 'spec_helper'

describe "gifts/index" do
  before(:each) do
    assign(:gifts, [
      stub_model(Gift,
        :recipient_email => "Recipient Email",
        :given_email => "Given Email",
        :note_gift => "MyText",
        :gitf_type => 1
      ),
      stub_model(Gift,
        :recipient_email => "Recipient Email",
        :given_email => "Given Email",
        :note_gift => "MyText",
        :gitf_type => 1
      )
    ])
  end

  it "renders a list of gifts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Recipient Email".to_s, :count => 2
    assert_select "tr>td", :text => "Given Email".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
