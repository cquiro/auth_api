# Preview all emails at http://localhost:3000/rails/mailers/auth_mailer
class AuthMailerPreview < ActionMailer::Preview
  def auth_attempt_notification
    AuthMailer.auth_attempt('email@example.com', 'mobile')
  end
end
