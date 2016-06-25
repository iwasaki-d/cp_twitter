class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :tweet_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :likes, :tweet_id, unique: false, name: 'index_likes_on_tweet_id'
    add_index :likes, :user_id, unique: false, name: 'index_likes_on_user_id'
    add_index :likes, [:user_id, :tweet_id], unique: true, name: 'index_likes_on_unique'
  end
end
