# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'

User.delete_all
Tweet.delete_all
Relationship.delete_all

FactoryGirl.create_list(:user, 6)
FactoryGirl.create(:relationship, user_id:1, following_user_id:2)
FactoryGirl.create(:relationship, user_id:1, following_user_id:3)

FactoryGirl.create(:relationship, user_id:2, following_user_id:3)
FactoryGirl.create(:relationship, user_id:2, following_user_id:4)

FactoryGirl.create(:relationship, user_id:3, following_user_id:4)
FactoryGirl.create(:relationship, user_id:3, following_user_id:5)

tweet = User.find_by_param('user1').tweets.first
FactoryGirl.create(:tweet, user_id:2, parent:tweet, body: 'user2 -> user1 コメントテスト')
FactoryGirl.create(:tweet, user_id:3, parent:tweet, body: 'user3 -> user1 コメントテスト')

tweet = User.find_by_param('user5').tweets.first
FactoryGirl.create(:like, user_id:1, tweet_id: tweet.id )
FactoryGirl.create(:like, user_id:2, tweet_id: tweet.id )

tweet = User.find_by_param('user4').tweets.first
FactoryGirl.create(:like, user_id:5, tweet_id: tweet.id )


