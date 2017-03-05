class SessionsController < ApplicationController
  def create
    user = User.find_by_token(params[:token])
    if user
      user.nullify_login_token!
      self.current_user = user
      redirect_to root_path, notice: 'Signed-in sucesfully'
    else
      redirect_to root_path, alert: 'Invalid or expired login link'
    end
  end

  def destroy
    self.current_user = NullUser.new
    redirect_to root_path, notice: 'Sucesfully signed-out'
  end
end
