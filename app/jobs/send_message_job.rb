class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message, current_account)
    sent_by_me = message.sender == current_account
    time = message.created_at.today? ? message.created_at.strftime("%I:%M %P") : message.created_at.strftime("%m/%d/%Y, %H:%M")
    partner = current_account == message.sender ? message.receiver : message.sender
    profile_picture_path = sent_by_me ? avatar_path(account: current_account) : avatar_path(account: partner)
    html = ApplicationController.render(partial: 'messages/message', locals: { message: message, sent_by_me: sent_by_me, partner: partner, time: time, picture: profile_picture_path })
    chat_id = [message.sender_id, message.receiver_id].sort.join("")
    ActionCable.server.broadcast("message_channel_#{chat_id}", html: html)
  end

  private
  def avatar_path(account:)
    if account&.avatar&.blob.nil?
      'http://localhost:3000/default.png'
    else
      Rails.application.routes.url_helpers.rails_blob_url(account.avatar.blob, Rails.application.config.action_mailer.default_url_options)
    end
  end
end
