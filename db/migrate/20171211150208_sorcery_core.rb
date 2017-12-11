class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.string :comment

      t.timestamps                :null => false
    end

    add_index :users, :email, unique: true
  end
end
