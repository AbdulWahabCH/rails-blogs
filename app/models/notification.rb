class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, polymorphic: true
  belongs_to :notifiable, polymorphic: true
  after_create_commit :broadcast_notification


  enum action: { commented: 0, reacted: 1, collaborated: 2, invited: 3 }
  enum status: { unread: 0, read: 1 }

  validates :action, presence: true
  validates :notifiable, presence: true


  # def self.create_notification(invited, current, notify, action_done)
  #   notification = Notification.build(
  #     user: invited,
  #     actor: current,
  #     notifiable: notify,
  #     action: action_done
  #   )
  #   if notification.save
  #     puts "------------ ================= #{notification.id} -- #{notification.user} ============== --------------"
  #   else
  #     logger.error "Notification could not be saved: #{notification.errors.full_messages.join(", ")}"
  #   end
  # end

  private

  def broadcast_notification
    NotificationChannel.broadcast_to(user, { message: "#{self.actor.username} ---------- has -------- #{self.action} on your post", status: self.status })
  end
end
