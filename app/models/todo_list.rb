class TodoList < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :todo_items
end
