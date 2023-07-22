class AddNotNullConstraintToTableName < ActiveRecord::Migration[6.1]
  def change
    change_column_null :cloths, :privacy_status, :integer, default: 0
  end
end
