class CreateUserArts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_arts do |t|
      t.references :user, foreign_key: true
      t.string :artimage
      t.string :comment

      t.timestamps
    end
  end
end
