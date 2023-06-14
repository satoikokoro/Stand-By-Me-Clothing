class CreateCloths < ActiveRecord::Migration[6.1]
  def change
    create_table :cloths do |t|
      t.integer :user_id,         null: false
      t.integer :storage_id,      null: false
      t.integer :genre_id,        null: false
      t.string :name,             null: false
      t.text :description,        null: false
      t.integer :status,
      t.timestamps
    end
  end
end
