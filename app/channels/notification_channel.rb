# app/channels/notification_channel.rb
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific notification channel for the current user
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
