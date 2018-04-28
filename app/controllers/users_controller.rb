class UsersController < ApplicationController
  def index
    render json: users, status: :ok
  end

  def show
    render json: user, status: :ok
  end

  def create
    new_user = User.new(user_params)

    if new_user.save
      render json: new_user, status: :created
    else
      render json: new_user.errors, status: :unprocessable_entity
    end
  end

  def update
    if user.update(update_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user.destroy
    head :no_content
  end

  private

  def users
    @users ||= User.all
  end

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :image)
  end

  def update_params
    params.require(:user).permit(:image)
  end
end
