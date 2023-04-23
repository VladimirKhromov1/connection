class AddResponsedToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :responsed, :boolean, default: false
  end
end
