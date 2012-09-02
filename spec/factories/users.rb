# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person-#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    password "MyString"
    password_confirmation "MyString"
  end
end
