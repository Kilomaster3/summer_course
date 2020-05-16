require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    FactoryBot.build(:user,
           email: 'test@example.com',
           password: '1234567',
           password_confirmation:'1234567')
  end

  context 'invalid' do
    let(:user) { User.new }
    it 'without params' do
      expect(user).to be_invalid
    end
  end


  context 'email' do
    let(:user) { User.new }
    it "reject duplicate email addresses" do
      FactoryBot.create(:user)
      member_with_duplicate_email = FactoryBot.build(:user)
      expect(member_with_duplicate_email).to be_valid
    end
  end


  context 'valid' do

    it 'with email and password' do
      expect(user).to be_valid
    end

    context 'factory' do

      it 'has a valid factory' do
        expect(user).to be_valid
      end
    end
  end



end