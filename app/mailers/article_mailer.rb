class ArticleMailer < ApplicationMailer
    # default from: 'no-reply@example.com' # Set your default email

    def review_request(user, article, message)
      @user = user
      @article = article
      @message = message
      # @article_url = Rails.application.routes.url_helpers.article_url(article.id) # URL to article
      @article_url = article_url(@article)
      mail(to: @user.email, subject: "Warning: Please review your article") do |format|
        format.html { render "review_request" }
      end
    end
end
