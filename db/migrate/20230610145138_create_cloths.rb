class CreateCloths < ActiveRecord::Migration[6.1]
  def change
    create_table :cloths do |t|

      t.timestamps
    end
  end
end
