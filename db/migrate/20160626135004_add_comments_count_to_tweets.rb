class AddCommentsCountToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :comments_count, :integer, null: false, default: 0
  end
end
