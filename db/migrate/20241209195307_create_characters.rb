class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :furigana, null: false
      t.string :job, null: false
      t.integer :age, null: false
      t.string :gender, null: false
      t.string :from, null: false
      t.integer :str, null: false
      t.integer :con, null: false
      t.integer :dex, null: false
      t.integer :app, null: false
      t.integer :siz, null: false
      t.integer :edu, null: false
      t.text :possession
      t.text :memo
      t.json :custom_skills
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
