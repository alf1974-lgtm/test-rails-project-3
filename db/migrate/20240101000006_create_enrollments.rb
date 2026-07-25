class CreateEnrollments < ActiveRecord::Migration[7.1]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :class_session, null: false, foreign_key: true
      t.string :grade   # e.g. "A", "B+", "C", or nil if not yet graded

      t.timestamps
    end

    add_index :enrollments, [:student_id, :class_session_id], unique: true
  end
end
