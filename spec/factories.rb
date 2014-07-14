FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@test.com" }
    password '12345678'
    password_confirmation '12345678'
  end

  factory :timezone do
    sequence(:name) { |n| "Timezone ##{n}" }
    sequence(:city) { |n| "City ##{n}" }
    sequence(:gmt) { |n| n - 5 }
  end
end