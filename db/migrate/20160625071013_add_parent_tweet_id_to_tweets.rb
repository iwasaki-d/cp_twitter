class AddParentTweetIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :parent_tweet_id, :integer
    add_index :tweets, :parent_tweet_id, name: 'index_tweets_on_parent_tweet_id'
  end
end
