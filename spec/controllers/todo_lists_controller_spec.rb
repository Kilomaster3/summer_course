require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  let(:user) {FactoryBot.create(:user) }
  let(:todo_list) { create(:todo_list, user: user) }


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

      it 'find right user' do
        get :index

        expect(@user).to eq @user
      end
    end
  end
