class BrowseController < ApplicationController
  skip_before_action :verify_authenticity_token
  def browse
    licked_account_ids = Like.where(account_id: current_account.id).map(&:liked_account_id)
    licked_account_ids << current_account.id
    @accounts = Accounts::GetAccountData.call(accounts: Account.where.not(id: licked_account_ids), variant: :slide)
  end

  def matches
    @matches = Accounts::GetAccountData.call(accounts: current_account.matches, variant: :match)
    @current_account_id = current_account.id
  end

  def approve
    account_id = params[:id]

    new_like = Like.new(liked_account_id: account_id)
    new_like.account_id = current_account.id

    if new_like.save
      like = Like.where(account_id: account_id, liked_account_id: current_account.id).count
      @they_like_us = like > 0
    else

    end
  end

  def decline

  end
end