FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:password) { |n| "pass#{n}" }
    sequence(:password_confirmation) { |n| "pass#{n}" }
    email ""

    after(:create) do |user|
      5.times { create(:twitter, user: user) }
    end
  end

  factory :twitter do
    sequence(:text) { |text_n| "#{user.name}-テストツィート#{text_n}" }
    user
  end
end
