class CreateSemesters < ActiveRecord::Migration[8.1]
  def change
    create_table :semesters do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :semesters, :name, unique: true
  end
end
