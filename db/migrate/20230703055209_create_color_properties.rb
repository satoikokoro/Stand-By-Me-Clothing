class CreateColorProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :color_properties do |t|
      t.integer :red
      t.integer :green
      t.integer :blue
      t.decimal :score, precision: 10, scale: 9
      t.decimal :pixelFraction, precision: 9, scale: 8
      t.timestamps
    end
  end
end
