class AddUserIdIndexToTwitter < ActiveRecord::Migration
  def change
    add_index :twitter, :user_id, unique: false, name: 'idx_user_id'
  end
end
