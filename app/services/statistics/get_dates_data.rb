class Statistics::GetDatesData
  include Callable

  def initialize(current_account_id:)
    @current_account_id = current_account_id
  end

  def call
    {
    "Accepted dates": Location.where(creator_id: Account.find_by(id: current_account_id), approved: true).count,
    "Declined dates": Location.where(creator_id: Account.find_by(id: current_account_id), declined: true).count
    }
  end

  private

  attr_reader :current_account_id
end