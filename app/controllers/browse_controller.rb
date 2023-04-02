class BrowseController < ApplicationController
  def browse
    @users = GetAccountData.call(accounts: Account.all)
  end

  def approve

  end

  def decline

  end
end