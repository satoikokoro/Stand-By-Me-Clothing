class AddUserIdToStorages < ActiveRecord::Migration[6.1]
  def change
    add_column :storages, :user_id, :integer
  end
end
