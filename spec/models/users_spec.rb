require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe'associations' do
    it { should have_many(:goals) }
  end

  describe '::find_by_credentials' do
    it 'should find a user by username and password' do
      user = User.create(username: 'abc', email: 'abc.com', password: 'cbaabc')
      expect(User).to receive(:find_by_credentials).with('abc', 'cbaabc')
      User.find_by_credentials('abc', 'cbaabc')
    end
  end

  

end
