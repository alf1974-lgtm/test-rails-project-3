class CreateSemesters < ActiveRecord::Migration[7.1]
  def change
    create_table :semesters do |t|
      t.string :name,       null: false   # e.g. "Fall 2026"
      t.date   :start_date
      t.date   :end_date

      t.timestamps
    end
    add_index :semesters, :name, unique: true
  end
end
