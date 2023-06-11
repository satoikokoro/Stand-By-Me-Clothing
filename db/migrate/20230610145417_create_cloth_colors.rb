class CreateClothColors < ActiveRecord::Migration[6.1]
  def change
    create_table :cloth_colors do |t|
      t.integer :cloth_id,         null: false
      t.integer :color_id,         null: false
      t.timestamps
    end
  end
end
