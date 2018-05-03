require "rails_helper"

RSpec.describe AuthMailer, type: :mailer do
  describe "verification attempt notification" do
    let(:mail) { AuthMailer.auth_attempt('email@example.com', 'mobile') }

    it "renders the headers" do
      expect(mail.subject).to eq("Verification attempt from this email")
      expect(mail.to).to eq(["email@example.com"])
      expect(mail.from).to eq(["no-reply@userauth.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include "this email from a mobile device."
    end
  end
end
