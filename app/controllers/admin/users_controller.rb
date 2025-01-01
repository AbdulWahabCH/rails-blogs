class Admin::UsersController < Admin::BaseController
  skip_before_action :verify_authenticity_token, only: [ :destroy, :update ]
  before_action :set_user, only: [ :show, :destroy ]

  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

  def show
    render json: @user, serializer: UserSerializer
  end

  def update
    ActiveRecord::Base.transaction do
      @user = User.find(params[:id])
      if file.is_a?(ActionDispatch::Http::UploadedFile)
        @user.avatar.purge if @user.avatar.attached?
        @user.avatar.attach(user_params[:avatar])
      end
    end

    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found

    rescue ActiveRecord::RecordInvalid => e
      render json: {
        error: "Validation failed",
        details: e.message,
        errors: @user&.errors&.full_messages
      }, status: :unprocessable_entity

    rescue StandardError => e
      render json: {
        error: "An error occurred while updating the user",
        details: e.message
      }, status: :internal_server_error
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :role, :avatar)
  end
end
