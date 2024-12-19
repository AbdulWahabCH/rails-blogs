# app/controllers/admin/sessions_controller.rb
class Admin::SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [ :create ]

    def create
      user = User.find_by(email: params[:email])
      if user&.valid_password?(params[:password]) && user.admin?
        token = generate_jwt(user)
        render json: {
          token: token,
          user: UserSerializer.new(user).serializable_hash
        }, status: :created
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end

    private

    def generate_jwt(user)
      JWT.encode({ user_id: user.id, exp: 12.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)
    end
end
