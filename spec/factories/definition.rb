# define gift
FactoryGirl.define do
  factory :gift do
  end
end

# define address
FactoryGirl.define do
  factory :address do
    first_name "John"
    last_name "Pan"
    address_1 "123 King Street"
    address_2 ""
    city "San"
    state "CA"
    zip "94103"
    phone "1111111111"
  end
end

FactoryGirl.define do
  factory :user do
    email "test@littlespark.com"
    first_name "AAA"
    last_name "BBB"
    password "123123"
    password_confirmation "123123"
  end
end

FactoryGirl.define do
  factory :baby do
    first_name "Peter"
    last_name "Pan"
    birthday Time.parse("2011-01-01")
    gender -1
    association :parent, factory: :user
  end
end

FactoryGirl.define do
  factory :order do
    plan_type 2
    price 99.99
    tax 1
    shipping_fee 0
    transaction_code "2183005924"
    transaction_date Time.parse("2013-01-21")
    transaction_status "2"

    association :baby, factory: :baby, first_name: "Peter", last_name: "Pan"
    association :shipping_address, factory: :address, first_name: "John"
    association :billing_address, factory: :address, first_name: "David"
  end
end


