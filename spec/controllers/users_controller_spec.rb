require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:body) { JSON.parse(response.body) if response.body.present? }

  describe 'GET #index' do
    let!(:users) do
      users_arr = []
      5.times do
        users_arr << create(:user)
      end
      users_arr
    end

    before :each do
      get :index
    end

    it { expect(response).to have_http_status(:ok) }

    it 'returns 5 users' do
      expect(body.count).to eq 5
    end
  end

  describe 'GET #show' do
    before :each do
      @user = create(:user)
      get :show, params: { id: @user.id }
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:new_user_attributes) { attributes_for(:user) }

      before :each do
        post :create, params: { user: new_user_attributes }
      end

      it { expect(response).to have_http_status(:created) }

      it 'creates the user' do
        expect(User.exists?(email: new_user_attributes[:email])).to be true
      end
    end

    context 'without an email' do
      let!(:attributes_no_email) { attributes_for(:user, email: nil) }

      before :each do
        post :create, params: { user: attributes_no_email }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'does not create the user' do
        expect(User.count).to be 0
      end

      it 'returns an error message' do
        expect(body['email']).to include 'can\'t be blank'
      end
    end

    context 'without an image' do
      let!(:attributes_no_image) { attributes_for(:user, image: nil) }

      before :each do
        post :create, params: { user: attributes_no_image }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'does not create the user' do
        expect(User.count).to be 0
      end

      it 'returns an error message' do
        expect(body['image']).to include 'can\'t be blank'
      end
    end
  end

  describe 'PUT #update' do
    context 'when updating the image' do
      let!(:user) { create(:user, image: 'old_image_base64_code') }

      before :each do
        put :update, params: { id: user.id, user: { image: 'new_image_base64_code' } }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'updates the user\'s image' do
        user.reload
        expect(user.image).to eq 'new_image_base64_code'
      end
    end

    context 'when trying to update the email' do
      let!(:user) { create(:user, email: 'old@email.com') }

      before :each do
        put :update, params: { id: user.id, user: { email: 'new@email.com' } }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'does not update the user\'s email' do
        user.reload
        expect(user.email).to eq 'old@email.com'
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = create(:user, email: 'email@example.com')
      delete :destroy, params: { id: @user.id }
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'deletes the user' do
      expect(User.exists?(email: 'email@example.com')).to be false
    end
  end
end
