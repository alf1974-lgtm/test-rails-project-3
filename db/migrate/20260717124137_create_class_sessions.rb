class CreateClassSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :class_sessions do |t|
      t.references :course, null: false, foreign_key: true
      t.references :semester, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :class_sessions, %i[course_id semester_id teacher_id],
              unique: true,
              name: 'index_class_sessions_on_course_semester_teacher'
  end
end
