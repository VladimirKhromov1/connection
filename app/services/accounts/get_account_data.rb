class Accounts::GetAccountData
  include Callable

  VARIANTS = {
    slide: "600x600!",
    match: "400x400!",
  }.freeze

  def initialize(accounts:, variant:)
    @accounts = accounts
    @variant = variant
  end

  def call
    accounts.map do |account|
      {
        id: account.id,
        email: account.email,
        username: account&.username,
        firstName: account&.first_name,
        lastName: account&.last_name,
        photo: avatar_path(account: account),
        age: account.age,
        country: account.country,
        city: account.city
      }
    end
  end

  private

  attr_reader :accounts, :variant

  def avatar_path(account:)
    if account&.avatar&.blob.nil?
      'http://localhost:3000/default.png'
    elsif (account.avatar.metadata['width'] == 400 && account.avatar.metadata['height'] == 400) || (account.avatar.metadata['width'] == 600 && account.avatar.metadata['height'] == 600)
      Rails.application.routes.url_helpers.rails_blob_url(account.avatar.blob, Rails.application.config.action_mailer.default_url_options)
    else

      Rails.application.routes.url_helpers.rails_blob_url(account.avatar.blob, Rails.application.config.action_mailer.default_url_options)
    end
  end
end