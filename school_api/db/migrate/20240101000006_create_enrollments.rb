class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :class_session, null: false, foreign_key: true
      # student is a User with role "student"
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.string     :grade   # e.g. "A", "B+", "C", nil if not yet graded

      t.timestamps
    end

    add_index :enrollments, [ :class_session_id, :student_id ], unique: true
  end
end
