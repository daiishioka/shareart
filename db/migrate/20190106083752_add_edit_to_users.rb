class AddEditToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :instagram_id, :string
    add_column :users, :twitter_id, :string
    add_column :users, :facebook_id, :string
    add_column :users, :introduction, :text
  end
end
