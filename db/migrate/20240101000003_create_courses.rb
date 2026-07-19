class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string     :name,        null: false
      t.string     :code,        null: false   # e.g. "ENG101"
      t.text       :description
      t.references :department,  null: false, foreign_key: true

      t.timestamps
    end

    add_index :courses, :code, unique: true
  end
end
