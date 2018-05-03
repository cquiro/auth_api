require 'rails_helper'

RSpec.describe UserVerificationsController, type: :controller do
  describe "POST #create" do
    let!(:db_user) { create(:user, email: 'user@email.com', image: 'encoded_base64_image') }

    context "with correct image" do
      before :each do
        post :create, params: { email: db_user.email, image: db_user.image }
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context "with incorrect image" do
      before :each do
        post :create, params: { email: db_user.email, image: 'other_image' }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    it "sends verification attempt email" do
      ActiveJob::Base.queue_adapter = :test

      expect {
        post :create,  params: { email: db_user.email, image: db_user.image }
      }.to have_enqueued_job.on_queue('mailers')
    end
  end
end
