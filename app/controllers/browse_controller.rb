class BrowseController < ApplicationController
  skip_before_action :verify_authenticity_token
  def browse
    licked_account_ids = Like.where(account_id: current_account.id).map(&:liked_account_id)
    dislicked_account_ids = Dislike.where(account_id: current_account.id).map(&:disliked_account_id)
    licked_account_ids << current_account.id
    ids = []
    ids << licked_account_ids
    ids << dislicked_account_ids
    @accounts = Accounts::GetAccountData.call(accounts: Account.where.not(id: ids), variant: :slide)
  end

  def matches
    @matches = Accounts::GetAccountData.call(accounts: current_account.matches, variant: :match)
    @current_account_id = current_account.id
    @wait_answer = Location.where(creator_id: current_account.id, responsed: "default").map { |location| location.recipient_id }
    @wait_answer_from_me = Location.where(recipient_id: current_account.id, responsed: "default" ).map { |location| location.creator_id }
  end

  def approve
    account_id = params[:id]
    account = Account.find_by(id: account_id)
    account.update rate: account.rate + 1
    Like.create(account_id: current_account.id, liked_account_id: account_id)
  end

  def decline
    account_id = params[:id]
    account = Account.find_by(id: account_id)
    account.update rate: account.rate - 1
    Dislike.create(account_id: current_account.id, disliked_account_id: account_id)
  end
end