class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.integer :credits, default: 3
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
