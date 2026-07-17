class CreateSemesters < ActiveRecord::Migration[7.2]
  def change
    create_table :semesters do |t|
      t.string :name, null: false
      t.string :season, null: false
      t.integer :year, null: false

      t.timestamps
    end

    add_index :semesters, :name, unique: true
    add_index :semesters, %i[season year], unique: true
  end
end
