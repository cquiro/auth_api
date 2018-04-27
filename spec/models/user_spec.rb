require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with email and image' do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
