class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.integer :default_value, null: false, default: 0
      t.string :calculation, null: false
      t.string :genre, null: false

      t.timestamps
    end
  end
end
