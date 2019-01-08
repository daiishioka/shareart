class UserArts < ActiveRecord::Migration[5.0]
  def change
    drop_table :user_arts
  end
end
