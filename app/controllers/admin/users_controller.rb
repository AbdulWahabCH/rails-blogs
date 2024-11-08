class Admin::UsersController < Admin::BaseController
  skip_before_action :verify_authenticity_token, only: [ :destroy, :update ]
    def index
      users = User.all
      render json: users, each_serializer: UserSerializer
    end

    def show
      user = User.find(params[:id])
      render json: user, serializer: UserSerializer
    end

    # def create
    #   user = User.new(user_params)
    #   if user.save
    #     render json: user, status: :created
    #   else
    #     render json: user.errors, status: :unprocessable_entity
    #   end
    # end

    # def update
    #   user = User.find(params[:id])
    #   if params[:user][:avatar].present?
    #     user.avatar.purge # Purge the old avatar
    #     user.avatar.attach(params[:user][:avatar]) # Attach the new avatar
    #   end
    #   if user_params[:avatar].present?
    #     @user.avatar.purge if @user.avatar.attached?
    #     @user.avatar.attach(user_params[:avatar])
    #   end

    #   if user.username != user_params[:username] && User.exists?(username: user_params[:username])
    #     render json: { error: "Username is already taken" }, status: :unprocessable_entity
    #     return
    #   end

    #   if user.update(user_params)
    #     render json: user, status: :ok
    #   else
    #     render json: user.errors, status: :unprocessable_entity
    #   end
    # end

    def update
      ActiveRecord::Base.transaction do
        @user = User.find(params[:id])
        # if user_params[:username].present? &&
        #    @user.username != user_params[:username] &&
        #    User.exists?(username: user_params[:username])
        #   raise ActiveRecord::RecordInvalid.new(@user), "Username is already taken"
        # end

        if file.is_a?(ActionDispatch::Http::UploadedFile)
          @user.avatar.purge if @user.avatar.attached?
          @user.avatar.attach(user_params[:avatar])
        end

        # unless @user.update(user_params.except(:avatar))
        #   raise ActiveRecord::RecordInvalid.new(@user)
        # end

        # render json: {
        #   message: "User updated successfully",
        #   user: {
        #     id: @user.id,
        #     username: @user.username,
        #     email: @user.email,
        #     role: @user.role,
        #     avatar_url: @user.avatar.attached? ? url_for(@user.avatar) : nil
        #   }
        # }, status: :ok
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
      user = User.find(params[:id])
      user.destroy
      head :no_content
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :role, :avatar)
    end
end
