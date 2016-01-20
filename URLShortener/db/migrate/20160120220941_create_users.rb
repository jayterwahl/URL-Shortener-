class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email, null: false, uniqueness: true
    end

    add_index :users, :email
  end
end
