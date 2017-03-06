class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  before_action :authenticate_user, only: [:edit, :update]

  def index
    @users = User.all
    authorize @users
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(permitted_attributes(@user))
      redirect_to users_path
    else
      render :edit
    end
  end

  def impersonate
    user = User.find(params[:id])
    self.current_user = user
    redirect_back fallback_location: root_path
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
