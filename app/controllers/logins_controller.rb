class LoginsController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])

    user.set_login_token!

    LoginMailer.login_link(user).deliver

    redirect_to root_path, notice: 'Login link sended to your email'
  end
end
