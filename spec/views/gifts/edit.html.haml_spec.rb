require 'spec_helper'

describe "gifts/edit" do
  before(:each) do
    @gift = assign(:gift, stub_model(Gift,
      :recipient_email => "MyString",
      :given_email => "MyString",
      :note_gift => "MyText",
      :gitf_type => 1
    ))
  end

  it "renders the edit gift form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gifts_path(@gift), :method => "post" do
      assert_select "input#gift_recipient_email", :name => "gift[recipient_email]"
      assert_select "input#gift_given_email", :name => "gift[given_email]"
      assert_select "textarea#gift_note_gift", :name => "gift[note_gift]"
      assert_select "input#gift_gitf_type", :name => "gift[gitf_type]"
    end
  end
end
