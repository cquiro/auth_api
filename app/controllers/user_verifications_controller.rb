class UserVerificationsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    AuthMailer.auth_attempt(params[:email], params[:user_agent]).deliver_later

    if user && user.image == params[:image]
      head :ok
    else
      head :unauthorized
    end
  end
end
