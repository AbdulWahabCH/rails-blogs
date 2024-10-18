class NotifyUsersAboutRecentPostsJob < ApplicationJob
  queue_as :default

  def perform
    articles = Article.posted_in_last_24_hours

    User.find_each do |user|
      begin
        UserMailer.recent_posts_notification(user, articles).deliver_now
        puts "------------------------------------------- jobs running----------------------------------------------"
      rescue StandardError => e
        Rails.logger.error "Failed to send email to #{user.email}: #{e.message}"
      end
    end
  end
end
