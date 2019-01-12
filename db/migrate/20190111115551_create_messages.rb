class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :from, foreign_key: { to_table: :users }
      t.references :to, foreign_key: { to_table: :users }
      t.text :content
      t.string :room_id

      t.timestamps
      
      t.index [:from_id, :to_id], unique: true
    end
  end
end
