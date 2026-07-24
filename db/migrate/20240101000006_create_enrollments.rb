class CreateEnrollments < ActiveRecord::Migration[7.1]
  def change
    create_table :enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :class_session, null: false, foreign_key: true
      t.decimal :grade, precision: 5, scale: 2

      t.timestamps
    end

    add_index :enrollments, [:user_id, :class_session_id], unique: true
  end
end
