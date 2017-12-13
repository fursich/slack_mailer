class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user

    mail(to: user.email, subject: "ご登録ありがとうございました", channel: 'general') # チャネル名を指定
  end

end
