class AddIndexesToFollowing < ActiveRecord::Migration
  def change
    add_index :following, [:user_id, :following_user_id] , unique: true, name: 'index_following_unique'
  end
end
