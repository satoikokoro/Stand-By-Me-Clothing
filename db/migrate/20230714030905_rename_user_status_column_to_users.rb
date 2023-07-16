class RenameUserStatusColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :user_status, :is_deleted
  end
end
