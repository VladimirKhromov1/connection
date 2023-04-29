class AddAcceptedAndDeclinedState < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :approved, :boolean, default: false
    add_column :locations, :declined, :boolean, default: false
  end
end
