class SampleMailer < ActionMailer::Base
  # ApplicationMailerを継承しないと普通にletter_openerにメールが飛ぶ

  def hello
    @user = User.first

    mail(to: User.first.email, subject: "こんにちは")
  end

end
