class CreateCharacterSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :character_skills do |t|
      t.references :character, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.integer :value, null: false, default: 0

      t.timestamps
    end
  end
end
