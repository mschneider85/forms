class LoginsController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])
    if user.valid?
      user.set_login_token!
      LoginMailer.login_link(user).deliver
      redirect_back fallback_location: root_path, notice: 'Login link sended to your email'
    else
      redirect_back fallback_location: root_path, flash: { error: 'E-Mail invalid' }
    end
  end
end
