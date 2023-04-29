class AddRateToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :rate, :numeric, default: 0
  end
end
