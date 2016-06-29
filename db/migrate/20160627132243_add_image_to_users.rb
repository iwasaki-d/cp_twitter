class AddImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image, :text
    add_column :users, :profile, :text, null: false, default: ''
  end
end
