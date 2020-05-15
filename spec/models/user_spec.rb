require 'rails_helper'

RSpec.describe User, type: :model do
  context 'invalid' do
    let(:user) { User.new }

    it 'without params' do
      expect(user).to be_invalid
    end
  end

  context 'valid' do
    let(:user) { User.new( email: 'abc123@gmail.com', password: '1234567')}

    it 'with email and password' do
      expect(user).to be_valid
    end
  end
end