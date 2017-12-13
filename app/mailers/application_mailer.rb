class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  # prodution環境以外では、slack mailerを使うようにヘッダーをオーバーライドする
  def mail(header_options = {}, &block)
    header_options.merge!(def_delivery_method_option).compact!
    super(header_options, &block)
  end

  private
  def def_delivery_method_option
    { delivery_method: delivery_method }
  end

  def delivery_method
    :slack_mailer unless Rails.env.production?
  end
end
