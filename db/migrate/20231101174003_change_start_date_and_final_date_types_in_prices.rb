class ChangeStartDateAndFinalDateTypesInPrices < ActiveRecord::Migration[7.0]
  def change
    change_column :prices, :start_date, :date
    change_column :prices, :final_date, :date
  end
end
