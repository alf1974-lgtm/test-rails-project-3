class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :role, null: false
      t.integer :grade
      t.references :advisor, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :role
  end
end
