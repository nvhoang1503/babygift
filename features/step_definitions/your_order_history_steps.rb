Given /^the order history with the following information exist:$/ do |table|
  user = User.find_by_email "test@littlesparks.com"
  user.first_name = "Mickey"
  user.last_name = "Mouse"
  user.save(:validate => false)
  baby = FactoryGirl.create(:baby, parent: user, first_name: "Peter", last_name: "Pan")
  order = FactoryGirl.create(:order, plan_type: 2, transaction_status: "2", transaction_code: "2183005924", transaction_date: Time.parse("2013-01-21 00:00:00 +0000"), baby: baby)
end

Given /^the shipping information exist with the order history:$/ do |table|
  order = Order.find_by_transaction_code "2183005924"
  address = order.shipping_address

  address.first_name = "Mickey"
  address.last_name = "Mouse"
  address.address_1 = "10 WW"
  address.address_2 = ""
  address.city = "San"
  address.state = "AK"
  address.zip = "11111"

  address.save
end

Given /^the payment information exist with the order history:$/ do |table|
  order = Order.find_by_transaction_code "2183005924"
  address = order.billing_address

  address.first_name = "Donald"
  address.last_name = "Duck"
  address.address_1 = "20 WW"
  address.address_2 = ""
  address.city = "San"
  address.state = "CA"
  address.zip = "22222"

  address.save
end

Given /^the order summary exist with the order history:$/ do |table|
  order = Order.find_by_transaction_code "2183005924"
  order.price = 99.99
  order.shipping_fee = 0
  order.transaction_status = "2"
  order.save
end

Then /^I should see "(.*?)" on "(.*?)" column of the table$/ do |value, column|
  case column
    when "ORDER" then
      with_scope(".row_number_0 .order_column") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
    when "DATE" then
      with_scope(".row_number_0 .date_column") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
    when "RECIPIENT" then
      with_scope(".row_number_0 .recipient_column") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
    when "CHILD" then
      with_scope(".row_number_0 .child_column") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
    when "PLAN" then
      with_scope(".row_number_0 .plan_column") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
  end
end

When /^I click "(.*?)" on "(.*?)" column$/ do |value, column|
  case column
    when "ORDER" then
      find(".row_number_0 .order_column a").click
    end
end

Then /^I should see "(.*?)" near "(.*?)" label$/ do |value, label|
  case label
    when "ORDER NUMBER" then
      with_scope(".main_info .order_number .info_text") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
    when "Order placed" then
      with_scope(".main_info .order_placed .info_text") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
    when "For Baby Gift" then
      with_scope(".main_info .baby .info_text") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
  end
end

Then /^I should see "(.*?)" on "(.*?)" section$/ do |value, section|
  case section
    when "ORDER SUMMARY" then
      with_scope(".order_summary_info") do
        if page.respond_to? :should
          page.should have_content(value)
        else
          assert page.has_content?(value)
        end
      end
  end
end

Then /^I should see "your order history" table$/ do
  with_scope(".your_order_history_table .table_headers .order_header") do
    if page.respond_to? :should
      page.should have_content("ORDER")
    else
      assert page.has_content?("ORDER")
    end
  end
end
