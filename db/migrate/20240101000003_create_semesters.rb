class CreateSemesters < ActiveRecord::Migration[7.1]
  def change
    create_table :semesters do |t|
      t.string :name, null: false
      t.string :term, null: false
      t.integer :year, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
