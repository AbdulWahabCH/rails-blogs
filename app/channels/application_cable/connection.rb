module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Devise::Controllers::Helpers

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      user_id = request.params[:token]
      if user_id.present?
        user = User.find_by(id: user_id)
        if user
          return user
        end
      end
      # This rejects unauthorized user access
      reject_unauthorized_connection
    end
  end
end
