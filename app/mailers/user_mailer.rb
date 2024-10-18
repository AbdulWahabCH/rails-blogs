class UserMailer < ApplicationMailer
    def recent_posts_notification(user, articles)
        @user = user
        @articles = articles
        mail(to: @user.email, subject: "Check out the latest articles posted in the last 24 hours!")
    end
end
