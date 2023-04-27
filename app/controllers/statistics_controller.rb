class StatisticsController < ApplicationController
  def index
    @account_hash = Statistics::GetData.call(current_account_id: current_account.id)
  end
end