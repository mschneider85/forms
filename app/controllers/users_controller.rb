class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  before_action :authenticate_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user && @user.update(username: params[:user][:username])
      redirect_to users_path
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
  end

  def authenticate_user
    if current_user.anonymous?
      redirect_to root_path, alert: 'Not authenticated'
    end
  end
end
