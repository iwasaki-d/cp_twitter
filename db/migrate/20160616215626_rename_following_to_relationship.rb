class RenameFollowingToRelationship < ActiveRecord::Migration
  def change
    rename_table :following, :relationships
  end
end
