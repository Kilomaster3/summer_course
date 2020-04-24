require 'rails_helper'

RSpec.describe TodoListsController, type: :model do
  describe "GET #index" do
    it "return collection" do
      @todo_list = todo_list.create
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
