class AddClothIdToColorProperties < ActiveRecord::Migration[6.1]
  def change
    add_reference :color_properties, :cloth, null: false, foreign_key: true
  end
end
