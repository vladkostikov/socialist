class FixUniqueUsername < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :username, unique: true
    add_index :users, :username
  end
end
