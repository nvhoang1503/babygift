Then /^I should see title of Account Summary page$/ do
  page.should have_css(".page-title")
  with_scope(".page-title") do
    if page.respond_to? :should
      page.should have_content(I18n.t("content.page.account_sum.step").upcase)
    else
      assert page.has_content?(I18n.t("content.page.account_sum.step").upcase)
    end
  end
  page.evaluate_script("$('.page-title').css('font-size')").should == "22px"
  page.evaluate_script("$('.page-title').css('font-family')").should == "'GudeaBold'"
  page.evaluate_script("$('.page-title').css('color')").should == "rgb(47, 180, 149)"
end

Then /^I should see Name, Email, Password section in the middle$/ do
  page.should have_css("#personal-info .title")
  with_scope("#personal-info .title") do
    if page.respond_to? :should
      page.should have_content(I18n.t("content.page.account_sum.personal_title"))
    else
      assert page.has_content?(I18n.t("content.page.account_sum.personal_title"))
    end
  end
  page.evaluate_script("$('#personal-info .title').css('font-size')").should == "18px"
  page.evaluate_script("$('#personal-info .title').css('font-family')").should == "'GudeaBold'"
  page.evaluate_script("$('#personal-info .title').css('color')").should == "rgb(68, 70, 75)"
  with_scope("#personal-info") do
    if page.respond_to? :should
      page.should have_content(@current_user.email)
    else
      assert page.has_content?(@current_user.email)
    end
  end
  page.evaluate_script("$('#personal-info .underline-link').css('color')").should == "rgb(47, 180, 149)"
  page.evaluate_script("$('#personal-info .underline-link').css('font-size')").should == "16px"
  page.evaluate_script("$('#personal-info .underline-link').css('font-family')").should == "\"Gudea\",serif"
end

Then /^I should see Payment Information section in the middle$/ do
  page.should have_css("#payment-info .title")
  with_scope("#payment-info .title") do
    if page.respond_to? :should
      page.should have_content(I18n.t("content.page.account_sum.payment_title"))
    else
      assert page.has_content?(I18n.t("content.page.account_sum.payment_title"))
    end
  end
  page.evaluate_script("$('#payment-info .title').css('font-size')").should == "18px"
  page.evaluate_script("$('#payment-info .title').css('font-family')").should == "'GudeaBold'"
  page.evaluate_script("$('#payment-info .title').css('color')").should == "rgb(68, 70, 75)"
end

Then /^I should see Your Children and Plan section in the middle$/ do
  page.should have_css("#child-n-plan .title")
  with_scope("#child-n-plan .title") do
    if page.respond_to? :should
      page.should have_content(I18n.t("content.page.account_sum.child_n_plan_title"))
    else
      assert page.has_content?(I18n.t("content.page.account_sum.child_n_plan_title"))
    end
  end
  page.evaluate_script("$('#child-n-plan .title').css('font-size')").should == "18px"
  page.evaluate_script("$('#child-n-plan .title').css('font-family')").should == "'GudeaBold'"
  page.evaluate_script("$('#child-n-plan .title').css('color')").should == "rgb(68, 70, 75)"
end
