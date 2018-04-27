require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with email and image' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include 'can\'t be blank'
    end

    it 'is invalid without an image' do
      user = build(:user, image: nil)
      user.valid?
      expect(user.errors[:image]).to include 'can\'t be blank'
    end
  end
end
