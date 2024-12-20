class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show ]
  before_action :check_current_user, only: [ :show ]

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_current_user
    unless @user == current_user
      flash[:alert] = "You are not authorized to view this profile."
      redirect_to root_path
    end
  end
end
