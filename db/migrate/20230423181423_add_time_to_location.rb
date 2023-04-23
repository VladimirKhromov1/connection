class AddTimeToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :time_of_date, :time
  end
end
