class CreateStorages < ActiveRecord::Migration[6.1]
  def change
    create_table :storages do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
