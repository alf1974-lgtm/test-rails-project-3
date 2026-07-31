class CreateSemesters < ActiveRecord::Migration[7.1]
  def change
    create_table :semesters do |t|
      t.string :name,       null: false   # e.g. "Fall 2026"
      t.date   :start_date, null: false
      t.date   :end_date,   null: false

      t.timestamps
    end

    add_index :semesters, :name, unique: true
  end
end
