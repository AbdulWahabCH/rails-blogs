class TestMailer < ApplicationMailer
    def test_email
      mail(to: "test@gmail.com", subject: "Test Email") do |format|
        format.text { render plain: "This is a test email." }
      end
    end
end
