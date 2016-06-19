class AddTweetsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tweets_count, :integer, null: false, default: 0
  end
end
