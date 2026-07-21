class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :code, null: false       # e.g. "ENG101", "MTH201"
      t.text :description
      t.integer :credits, null: false, default: 3
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end

    add_index :courses, :code, unique: true
  end
end
