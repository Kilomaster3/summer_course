require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    FactoryBot.build(:user,
                     email: 'test@example.com',
                     password: '1234567',
                     password_confirmation: '1234567')
  end

  describe User do
    context 'invalid' do
      let(:user) { User.new }

      it 'without params' do
        expect(user).to be_invalid
      end
    end

    context 'email' do
      let(:user) { FactoryBot.create(:user) }

      it 'reject duplicate email addresses' do
        member_with_duplicate_email = FactoryBot.build(:user)
        expect(member_with_duplicate_email).to be_valid
      end

      context 'invalid' do
        let(:user) { User.new }
        it 'without params' do
          expect(user).to be_invalid
        end
      end

      context 'email' do
        let(:user) { FactoryBot.create(:user) }
        let(:email) { FactoryBot.create(:user, email: 'TEST@EXAMPLE.ORG') }
        it 'reject duplicate email addresses' do
          member_with_duplicate_email = FactoryBot.build(:user)
          expect(member_with_duplicate_email).to be_valid
        end

        it 'reject email addresses identical up to case' do
          member_with_duplicate_email = FactoryBot.build(:user, email: 'test@example.org')
          expect(member_with_duplicate_email).to be_valid
        end

        it 'accept valid email addresses' do
          addresses = %w[member@foo.com THE_USER@foo.bar.org first.last@foo.jp]
          addresses.each do |address|
            valid_email_member = FactoryBot.build(:user, email: address)
            expect(valid_email_member).to be_valid
          end
        end
      end

      it 'reject email addresses identical up to case' do
        member_with_duplicate_email = FactoryBot.build(:user, email: 'test@example.org')
        expect(member_with_duplicate_email).to be_valid
      end

      let(:user) { FactoryBot.create(:user) }

      it 'accept valid email addresses' do
        addresses = %w[member@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_member = FactoryBot.build(:user, email: address)
          expect(valid_email_member).to be_valid
        end
      end
    end
  end

  context 'valid' do
    it 'with email and password' do
      expect(user).to be_valid
    end

    it 'require a matching password confirmation' do
      expect(FactoryBot.build(:user, password_confirmation: 'invalid')). not_to be_valid
    end

    it 'reject short passwords' do
      short = 'a' * 5
      expect(FactoryBot.build(:user, password: short, password_confirmation: short)). not_to be_valid
    end
  end

  context 'factory' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end
  end
end
