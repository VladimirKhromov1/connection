class AccountsController < ApplicationController

  def index
    @users = Account.all
  end

  def show
    @sender = Account.find(params[:sender_id])
    @receiver = Account.find(params[:receiver_id])
    @messages = Message.where(sender_id: @sender.id, receiver_id: @receiver.id).or(Message.where(sender_id: @receiver.id, receiver_id: @sender.id))
    @chat_id = [@sender.id, @receiver.id].sort.join("")
  end
end