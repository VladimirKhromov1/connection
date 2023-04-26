class CreateDislikes < ActiveRecord::Migration[7.0]
  def change
    create_table :dislikes do |t|
      t.references :account
      t.integer :disliked_account_id

      t.timestamps
    end
  end
end
