class TodoList < ApplicationRecord
  belongs_to :user, optional: true , dependent: :destroy
  has_many :todo_items

  def has_completed_items?
    # code here
  end
end
