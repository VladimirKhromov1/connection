class GetAccountData
  include Callable

  def initialize(accounts:)
    @accounts = accounts
  end

  def call
    accounts.map do |account|
      {
        email: account.email,
        username: account&.username,
        firstName: account&.first_name,
        lastName: account&.last_name,
      }
    end
  end

  private

  attr_reader :accounts
end