class AuthMailer < ApplicationMailer
  default from: "no-reply@userauth.com"

  def auth_attempt(email, device)
    @email = email
    @device = device
    mail(to: email, subject: 'Verification attempt from this email')
  end
end
