require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:todo_list) { FactoryBot.create(:todo_list, user: user) }

  describe 'GET #index' do
    context 'guest' do
      it 'return error' do
        get :index
        expect(response).to be_redirect
      end
    end

    context 'log_in user' do
      before { sign_in(user, scope: :user) }

      it 'success' do
        get :index
        expect(response.status).to eq 200
      end
    end

    it 'responds successfully' do
      get :index
      expect(response.status).to eq 302
    end

    it 'find right user' do
      get :index
      expect(@user).to eq @user
    end
  end

  context 'search' do
    before { sign_in(user, scope: :user) }

    it 'look me up' do
      get :index
      expect(assigns(:user)).to eq(@user)
    end
  end

  describe 'POST #create' do
    context 'as a guest user' do
      it 'returns a 302 request' do
        get :create
        expect(response).to have_http_status 302
      end

      it 'redirects the page to /users/sign_in' do
        get :create
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context 'as an authorized user' do
      it 'adds a new TodoList' do
        sign_in user
        expect do
          post :create, params: {
            title: 'Test ',
            description: ' Test UP ？！'
          }
          expect(user).to be_create
        end
      end
    end

    context 'with invalid attributes' do
      it 'does not add a new TodoList' do
        sign_in user

        expect do
          post :create, params: {
            title: nil,
            description: 'Test UP ？!'
          }
          expect(user).to be_not_create
        end
      end
    end
  end
end
