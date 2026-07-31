class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :role, default: "student", null: false
      t.string :student_id
      t.string :employee_id

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :student_id, unique: true, where: "student_id IS NOT NULL"
    add_index :users, :employee_id, unique: true, where: "employee_id IS NOT NULL"
  end
end
