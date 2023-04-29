class AccountsController < ApplicationController

  def index
    @users = Account.all
  end

  def show
    @sender = Account.find(params[:sender_id])
    @receiver = Account.find(params[:receiver_id])
    @partner_avatar_path = avatar_path(account: @receiver)
    @me_avatar_path = avatar_path(account: @receiver)
    @messages = Message.where(sender_id: @sender.id, receiver_id: @receiver.id).or(Message.where(sender_id: @receiver.id, receiver_id: @sender.id))
    @chat_id = [@sender.id, @receiver.id].sort.join("")
  end

  def date
    @creator = Account.find(params[:creator_id])
    @recipient = Account.find(params[:recipient_id])
  end

  def top
    @accounts = Accounts::GetAccountData.call(accounts: Account.order(rate: :desc).first(3), variant: :slide)
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