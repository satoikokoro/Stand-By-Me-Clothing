class RenameStatusColumnToCloths < ActiveRecord::Migration[6.1]
  def change
    rename_column :cloths, :status, :privacy_status
  end
end
