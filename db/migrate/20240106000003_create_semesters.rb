class CreateSemesters < ActiveRecord::Migration[7.1]
  def change
    create_table :semesters do |t|
      t.string :name, null: false
      t.string :term, null: false
      t.integer :year, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end

    add_index :semesters, :name, unique: true
  end
end
