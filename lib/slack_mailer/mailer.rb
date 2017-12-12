require 'slack-ruby-client'

module SlackMailer
  class Mailer
    def initialize(config={})
      @client = Slack::Web::Client.new
      @channel_setting = config[:channel] || default_channel
    end

    def deliver!(mail)
      channel = '#' + ( mail[:channel].try(:value) || @channel_setting )
      @client.chat_postMessage(channel: channel, text: 'welcome mailが発送されました')
      @client.chat_postMessage(channel: channel, text: format(mail))
      # @client.chat_postMessage(channel: channel, text: "#{mail.to_s.inspect}")
    end

    private

    def format(mail)
      <<~"EOS"
      ```
        from:       #{mail.from}
        to:         #{mail.to                 || '（なし）'}
        cc:         #{mail.cc                 || '（なし）'}
        subject:    #{mail.subject            || '（なし）'}
      ```
      ```
        body(text):

        #{retrive_text_part(mail) || '（なし）'}
      ```
      ```
        body(html):

        #{retrive_html_part(mail) || '（なし）'}
      ```
      EOS
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

    def default_channel
      'general'
    end
  end
end
