class AddUsersToTodoLists < ActiveRecord::Migration[6.0]
  def change
    add_reference :todo_lists, :users, foreign_key: true
  end
end
