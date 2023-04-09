class Accounts::GetAccountData
  include Callable
  include ActionView::Helpers::AssetUrlHelper

  def initialize(accounts:)
    @accounts = accounts
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
      }
    end
  end

  private

  attr_reader :accounts

  def avatar_path(account:)
    if account&.avatar&.blob.nil?
      'http://localhost:3000/default.png'
    else
      resized_image = MiniMagick::Image.read(account.avatar.download)
      resized_image.resize("600x600!")

      account.avatar.attach(
        io: File.open(resized_image.path),
        filename: account.avatar.filename,
        content_type: account.avatar.content_type)

      Rails.application.routes.url_helpers.rails_blob_url(account.avatar.blob, Rails.application.config.action_mailer.default_url_options)
    end
  end
end