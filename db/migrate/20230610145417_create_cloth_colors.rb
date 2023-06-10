class CreateClothColors < ActiveRecord::Migration[6.1]
  def change
    create_table :cloth_colors do |t|

      t.timestamps
    end
  end
end
