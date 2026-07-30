class CreateClassSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :class_sessions do |t|
      t.references :course,   null: false, foreign_key: true
      t.references :semester, null: false, foreign_key: true
      # teacher is a User with role "teacher"
      t.references :teacher,  null: false, foreign_key: { to_table: :users }
      t.string     :room
      t.string     :schedule  # e.g. "MWF 10:00-10:50"

      t.timestamps
    end
  end
end
