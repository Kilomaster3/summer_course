require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:todo_list) { FactoryBot.create(:todo_list, users_id: user.id) }

  describe 'GET #index' do
    context 'guest' do
      it 'return error' do
        get :index
        expect(response).to be_redirect
      end
    end

    describe "get todo_list route", :type => :request do
      let(:todo_list) { FactoryBot.create(:todo_list, users_id: user.id) }

      it 'returns all questions' do
        expect(JSON.parse(response.body).size).to eq 20
      end

      it "returns http success" do
      expect(response).to have_http_status(:success)
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
        expect(response.status).to eq 302
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
            description: ' Test UP ？！',
            users_id: 1
          }
          expect(todo_list).to be_valid
        end
      end
    end

    context 'with invalid attributes' do
      it 'does not add a new TodoList' do
        sign_in user

        expect do
          post :create, params: {
            title: nil,
            description: 'Test UP ？!',
            users_id: 1
          }
          expect(todo_list).not_to be_valid
        end
      end
    end
  end

  describe '#show' do
    context 'as an authorized user' do
      it 'responds successfully' do
        sign_in user

        get :show, params: { id: todo_list.id }
        expect(response).to be_success
      end

      it 'returns a 200 response' do
        sign_in user

        get :show, params: { id: todo_list.id }
        expect(response.status).to eq 200
      end

      it 'does not respond successfully' do
        sign_in user

        get :show, params: { id: todo_list.id }
        expect(response).to_not be_success
      end

      it 'returns a 200 response' do
        get :show, params: { id: todo_list.id }
        expect(response.status).to eq 302
      end

      it 'redirects the page to /users/sign_in' do
        get :show, params: { id: todo_list.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'as an authorized user' do
      it 'deletes an article' do
        sign_in user

        expect do
          delete :destroy, params: { id: todo_list.id }
          expect(user).to be_valid
        end
      end

      it 'redirects the page to root_path' do
        sign_in user

        delete :destroy, params: { id: todo_list.id }
        expect(response).to redirect_to root_path
      end

      it 'returns a 302 response' do
        delete :destroy, params: { id: todo_list.id }
        expect(response.status).to eq 302
      end

      it 'redirects the page to /users/sing_in' do
        delete :destroy, params: { id: todo_list.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
