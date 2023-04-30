class AddCountryAndCityToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :country, :string, null: false, default: ""
    add_column :accounts, :city, :string, null: false, default: ""
  end
end
