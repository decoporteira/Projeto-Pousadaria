class FixColumnNameIsPetsAllowed < ActiveRecord::Migration[7.0]
  def change
    rename_column :inns, :is_pets_allowed, :pet
  end
end
