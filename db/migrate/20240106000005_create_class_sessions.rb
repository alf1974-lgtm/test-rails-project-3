class CreateClassSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :class_sessions do |t|
      t.references :course, null: false, foreign_key: true
      t.references :semester, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.string :room
      t.string :schedule
      t.integer :max_enrollment, default: 30

      t.timestamps
    end
  end
end
