class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      # student is a User with role "student"
      t.references :student,       null: false, foreign_key: { to_table: :users }
      t.references :class_session, null: false, foreign_key: true
      t.string     :grade   # e.g. "A", "B+", "C", nil if not yet graded

      t.timestamps
    end

    add_index :enrollments, [ :student_id, :class_session_id ], unique: true,
              name: "index_enrollments_on_student_and_class_session"
  end
end
