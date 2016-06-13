class AddUserIdIndexToTweet < ActiveRecord::Migration
  def change
    add_index :tweets, :user_id, unique: false, name: 'index_tweets_on_user_id'
  end
end
