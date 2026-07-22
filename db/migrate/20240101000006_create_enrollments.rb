class CreateEnrollments < ActiveRecord::Migration[7.1]
  # Enrollments are the join between a student (User) and a ClassSession.
  # They also carry the student's grade for that class session.
  def change
    create_table :enrollments do |t|
      t.references :class_session, null: false, foreign_key: true
      # student is a User with role "student"
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.string     :grade   # e.g. "A", "B+", "C", nil if not yet graded

      t.timestamps
    end

    add_index :enrollments, [:class_session_id, :student_id], unique: true,
              name: "index_enrollments_on_class_session_and_student"
  end
end
