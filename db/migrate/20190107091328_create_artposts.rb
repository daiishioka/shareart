class CreateArtposts < ActiveRecord::Migration[5.0]
  def change
    create_table :artposts do |t|
      t.string :artimage
      t.text :coment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
