# frozen_string_literal: true

class SendNotifications
  def initialize(user, message, data = {})
    @user = user
    @message = message
    @data = data
    # Set apns-topic for production notifications
    # See: https://gist.github.com/naumov/b7a0a320336c3d396ce5cffcbcf42c1e
    @data.merge!(headers: { 'apns-topic': ENV['APNS_BUNDLE_ID'] }) if ENV.key?('APNS_BUNDLE_ID')
  end

  def call
    send_notification_to_devices
  end

  private

  def send_notification_to_devices
    app = Rpush::Apns2::App.first

    @user.installations.each do |installation|
      n = Rpush::Apns2::Notification.new
      n.app = app
      n.device_token = installation.token
      n.alert = @message
      n.data = @data
      n.save!
    end
  end
end
