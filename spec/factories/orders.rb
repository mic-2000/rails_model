# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    sequence(:nom) { |n| "#{n}" }
    user
    items { [FactoryGirl.create(:item)] }
  end
end
