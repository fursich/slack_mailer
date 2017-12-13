
module SlackMailer
  class Mailer
    include ActionView::Helpers::SanitizeHelper

    def initialize(config={})
      @channel_setting = config[:channel] || default_channel
    end

    def deliver!(mail)
      channel     = set_channel(mail)
      attachments = compose_attachments(mail)
      SlackNotifier::Notification.post(channel: channel, **attachments)
    end

    private
    def compose_attachments(mail)
      header = compose_header
      body   = compose_body(mail)
      SlackNotifier::Format.compose_attachments(header, body)
    end

    def compose_header
      {
        title: 'メールが発送されました',
        text:  "#{Rails.env}からメールが送信されました",
      }
    end

    def compose_body(mail)
      {
        subject:      "#{mail.subject || '（なし）'}",
        from:         "#{mail.from}",
        to:           "#{mail.to      || '（なし）'}",
        cc:           "#{mail.cc      || '（なし）'}",
        'body(text)': "#{retrive_text_part(mail)            || '（なし）'}",
        'body(html)': "#{strip_tags(retrive_html_part(mail)) || '（なし）'}",
      }
    end

    def retrive_text_part(mail)
      if mail.multipart?
        mail.text_part.body.decoded
      elsif plain_text?(mail)
        mail.body.decoded
      end
    end

    def retrive_html_part(mail)
      if mail.multipart?
        mail.html_part.body.decoded
      elsif plain_html?(mail)
        mail.body.decoded
      end
    end

    def plain_text?(mail)
      (mail.mime_type =~ /^text\/plain$/i)
    end

    def plain_html?(mail)
      (mail.mime_type =~ /^text\/html$/i)
    end

    def set_channel(mail)
      channel = ( mail[:channel].try(:value) || @channel_setting )
    end

    def default_channel
      'general'
    end
  end
end
