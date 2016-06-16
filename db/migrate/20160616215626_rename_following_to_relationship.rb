class RenameFollowingToRelationship < ActiveRecord::Migration
  def change
    rename_table :following, :relationships
    rename_index :relationships, 'index_following_on_following_user_id', 'index_relationships_on_following_user_id'
    rename_index :relationships, 'index_following_unique', 'index_relationships_unique'
  end
end
