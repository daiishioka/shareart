class RenameSnsidColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :instagram_id, :instagram_url
    rename_column :users, :twitter_id, :twitter_url
    rename_column :users, :facebook_id, :facebook_url
  end
end
