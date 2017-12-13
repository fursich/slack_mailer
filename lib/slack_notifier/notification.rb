require 'uri'
require 'net/http'
require 'json'

module SlackNotifier
  module Notification
    module_function

    def post(username: 'slack notifier', channel: 'general', message: '', attachments: nil)
      payload = {
        channel:     '#'+channel,
        username:    username,
        text:        message,
        attachments: attachments
      }

      uri = URI.parse(slack_webhook_url)

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data( { :payload => JSON.generate( payload ) } )
        http.request(request)
      end
    end

    def slack_webhook_url
      "https://hooks.slack.com/services/" + ENV['SLACK_WEBHOOK_TOKEN']
    end
  end
end
