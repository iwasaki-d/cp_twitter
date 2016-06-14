FactoryGirl.define do
  factory :following do
    user_id 1
    following_user_id 1
  end

  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:password) { |n| "pass#{n}" }
    sequence(:password_confirmation) { |n| "pass#{n}" }
    email ""

    after(:create) do |user|
      5.times { create(:tweet, user: user) }
    end
  end

  factory :tweet do
    sequence(:body) { |text_n| "#{user.name}-テストツィート#{text_n}" }
    user
  end
end
