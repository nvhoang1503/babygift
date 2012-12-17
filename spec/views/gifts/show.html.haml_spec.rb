require 'spec_helper'

describe "gifts/show" do
  before(:each) do
    @gift = assign(:gift, stub_model(Gift,
      :recipient_email => "Recipient Email",
      :given_email => "Given Email",
      :note_gift => "MyText",
      :gitf_type => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Recipient Email/)
    rendered.should match(/Given Email/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
