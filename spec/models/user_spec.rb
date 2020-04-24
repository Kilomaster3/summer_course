require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:todo_items) }

  describe "#has_complete_items?" do
    let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }

    it "returns true with completed todo list items" do
      todo_list.todo_items.create(content: "Eggs", completed_at: 1.minute.ago)
      expect(todo_list.has_completed_items?).to be_truthy
    end
   end
  end
