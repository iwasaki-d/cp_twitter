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
Following.delete_all

FactoryGirl.create_list(:user, 5)
FactoryGirl.create(:following, user_id:1, following_user_id:2)
FactoryGirl.create(:following, user_id:1, following_user_id:3)

FactoryGirl.create(:following, user_id:2, following_user_id:3)
FactoryGirl.create(:following, user_id:2, following_user_id:4)

FactoryGirl.create(:following, user_id:3, following_user_id:4)
FactoryGirl.create(:following, user_id:3, following_user_id:5)
