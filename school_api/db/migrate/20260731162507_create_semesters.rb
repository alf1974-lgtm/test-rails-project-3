class CreateSemesters < ActiveRecord::Migration[8.1]
  def change
    create_table :semesters do |t|
      t.string :name
      t.string :season
      t.integer :year

      t.timestamps
    end
  end
end
