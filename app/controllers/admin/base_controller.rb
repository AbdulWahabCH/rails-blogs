class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  private

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
        @current_user = User.find(payload["user_id"])
      rescue JWT::DecodeError
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    else
      render json: { error: "Missing token" }, status: :unauthorized
    end
  end

  def authorize_admin!
    render json: { error: "Unauthorized" }, status: :forbidden unless @current_user&.admin?
  end
end
