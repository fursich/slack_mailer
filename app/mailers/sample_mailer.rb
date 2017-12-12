class SampleMailer < ActionMailer::Base

  def hello
    @user = User.first

    mail(to: User.first.email, subject: "こんにちは")
  end

end
