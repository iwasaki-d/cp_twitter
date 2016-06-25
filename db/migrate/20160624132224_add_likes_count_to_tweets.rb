class AddLikesCountToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :likes_count, :integer, null: false, default: 0
  end
end
