class UsersController < ApplicationController
  def index
    @users = User.all
    redirect_to new_user_session_path if current_user.nil?
  end

  def show
    @user = current_user
  end
end
