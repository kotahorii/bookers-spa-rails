class AddColumnMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :user_id, :integer, null: false
    remove_column :messages, :usr_id, :integer
  end
end
