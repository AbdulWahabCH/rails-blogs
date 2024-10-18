module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Devise::Controllers::Helpers

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      puts "Connection established for user: #{current_user.nil? ? 'nil' : current_user.email}"
    end

    protected

    def find_verified_user
      user_id = request.params[:token]
      if user_id.present?
        user = User.find_by(id: user_id)
        if user
          puts "User signed in: --------------------- #{user.email}"
          return user
        end
      end

      puts "User NOT signed in or user not found"
      reject_unauthorized_connection
    end
  end
end
