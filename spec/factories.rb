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

  factory :application, class: Doorkeeper::Application do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri 'https://app.com/callback'
  end

  factory :access_token, class: Doorkeeper::AccessToken do
    sequence(:resource_owner_id) { |n| n }
    application
    expires_in 2.hours

    factory :clientless_access_token do
      application nil
    end
  end
end