class AddUserToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, foreign_key: true
  end
end
