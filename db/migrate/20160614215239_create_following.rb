class CreateFollowing < ActiveRecord::Migration
  def change
    create_table :following do |t|
      t.integer :user_id
      t.integer :following_user_id

      t.timestamps null: false
    end

    add_index :following, :following_user_id, unique: false, name: 'index_following_on_following_user_id'
  end
end
