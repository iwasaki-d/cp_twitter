FactoryGirl.define do

  factory :user do
    sequence(:id)
    sequence(:name) { |n| "user#{n}" }
    sequence(:password) { |n| "pass#{n}" }
    sequence(:password_confirmation) { |n| "pass#{n}" }
    email ""

    after(:create) do |user|
      5.times do
        create(:tweet, user: user)
      end
    end
  end

  factory :auto_id_user, class: User do
    sequence(:name) { |n| "user#{n}" }
    sequence(:password) { |n| "pass#{n}" }
    sequence(:password_confirmation) { |n| "pass#{n}" }
    email ""

    after(:create) do |user|
      5.times do
        create(:tweet, user: user)
      end
    end
  end


  factory :tweet do
    sequence(:body) { |text_n| "#{user.name}-テストツィート#{text_n}" }
    user
  end

  factory :following do
    user_id 1
    following_user_id 1
  end

end
