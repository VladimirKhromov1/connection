class BrowseController < ApplicationController
  def browse
    @accounts = Accounts::GetAccountData.call(accounts: Account.where.not(id: current_account.id))
  end

  def approve

  end

  def decline

  end
end