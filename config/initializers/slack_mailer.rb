require 'slack_mailer/mailer.rb'

ActionMailer::Base.add_delivery_method :slack_mailer, SlackMailer::Mailer
Rails.application.config.action_mailer.slack_mailer_settings = {}
