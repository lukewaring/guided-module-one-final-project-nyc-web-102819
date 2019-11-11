class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :level_id
      t.string :character
      t.string :item_1
      t.string :item_2
      t.boolean :complete
      t.timestamps
    end
  end
end
